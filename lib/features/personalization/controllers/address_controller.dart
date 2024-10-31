import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/section_heading.dart';
import 'package:moraes_nike_catalog/data/address/address_repository.dart';
import 'package:moraes_nike_catalog/features/personalization/models/address_model.dart';
import 'package:moraes_nike_catalog/features/personalization/views/address/add_new_address.dart';
import 'package:moraes_nike_catalog/features/personalization/views/address/widgets/single_address.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/cloud_helper_functions.dart';
import 'package:moraes_nike_catalog/utils/helpers/networkmanager.dart';
import 'package:moraes_nike_catalog/utils/popups/full_screen_loader.dart';
import 'package:moraes_nike_catalog/utils/popups/loaders.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());

      return addresses;
    } catch (e) {
      MLoaders.errorSnackBar(
          title: 'Endereço não encontrado', message: e.toString());
      return [];
    }
  }

  Future addNewAddresses() async {
    try {
      MFullScreenLoader.openLoadingDialog(
          'Salvando Endereço...', MImages.lProcInfo);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MFullScreenLoader.stopLoading();
        return;
      }

      if (!addressFormKey.currentState!.validate()) {
        MFullScreenLoader.stopLoading();
        return;
      }

      final address = AddressModel(
          id: '',
          name: name.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          street: street.text.trim(),
          city: city.text.trim(),
          state: state.text.trim(),
          postalCode: postalCode.text.trim(),
          country: country.text.trim(),
          selectedAddress: true);
      final id = await addressRepository.addAddress(address);
      address.id = id;
      await selectAddress(address);

      MFullScreenLoader.stopLoading();
      MLoaders.successSnackBar(
          title: 'Sucesso!', message: 'Seu endereço foi salvo!');

      refreshData.toggle();
      resetFormFields();
      Navigator.of(Get.context!).pop();
    } catch (e) {
      MFullScreenLoader.stopLoading();
      MLoaders.errorSnackBar(
          title: 'Endereço não encontrado', message: e.toString());
    }
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              padding: const EdgeInsets.all(Sizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MSectionHeading(
                      title: 'Selecione o Endereço', showActionButton: false),
                  FutureBuilder(
                    future: getAllUserAddresses(),
                    builder: (_, snapshot) {
                      final response =
                          MCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot);
                      if (response != null) return response;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) {
                            MSingleAddress(
                              address: snapshot.data![index],
                              onTap: () async {
                                await selectedAddress(snapshot.data![index]);
                                Get.back();
                              },
                            );
                          });
                    },
                  ),
                  const SizedBox(height: Sizes.defaultSpace * 2),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () =>
                              Get.to(() => const AddNewAddressView()),
                          child: const Text('Adicionar Novo Endereço'))),
                ],
              ),
            ));
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
          title: '',
          onWillPop: () async {
            return false;
          },
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: const CircularProgressIndicator(color: Colors.blue));
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);

        newSelectedAddress.selectedAddress = true;
        selectedAddress.value = newSelectedAddress;

        await addressRepository.updateSelectedField(
            selectedAddress.value.id, true);
        Get.back();
      }
    } catch (e) {
      MLoaders.errorSnackBar(
          title: 'Erro ao selecionar', message: e.toString());
    }
  }
}
