import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/appbar/appbar.dart';
import 'package:moraes_nike_catalog/features/personalization/controllers/address_controller.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/validators/validation.dart';

class AddNewAddressView extends StatelessWidget {
  const AddNewAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: const MAppBar(
          showBackArrow: true, title: Text('Adicionar Novo Endereço')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                TextFormField(
                    controller: controller.name,
                    validator: (value) =>
                        MValidator.validadeEmptyText('Name', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_2_rounded),
                        labelText: 'Nome')),
                const SizedBox(height: Sizes.spaceBtwInputFields),
                TextFormField(
                    controller: controller.phoneNumber,
                    validator: MValidator.validatePhoneNumber,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone_android_outlined),
                        labelText: 'Telefone')),
                const SizedBox(height: Sizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: controller.street,
                          validator: (value) =>
                              MValidator.validadeEmptyText('Street', value),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.house_outlined),
                              labelText: 'Endereço')),
                    ),
                    const SizedBox(width: Sizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                          controller: controller.postalCode,
                          validator: (value) => MValidator.validadeEmptyText(
                              'Postal Code', value),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.code), labelText: 'CEP')),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: controller.city,
                          validator: (value) =>
                              MValidator.validadeEmptyText('City', value),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.location_city_rounded),
                              labelText: 'Cidade')),
                    ),
                    const SizedBox(width: Sizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                          controller: controller.state,
                          validator: (value) =>
                              MValidator.validadeEmptyText('State', value),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.local_post_office_rounded),
                              labelText: 'Estado')),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),
                TextFormField(
                    controller: controller.country,
                    validator: (value) =>
                        MValidator.validadeEmptyText('Country', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.where_to_vote_outlined),
                        labelText: 'País')),
                const SizedBox(height: Sizes.defaultSpace),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          controller.addNewAddresses();
                        },
                        child: const Text('Salvar')))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
