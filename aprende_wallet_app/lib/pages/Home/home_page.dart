import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import '../../components/navBar.dart';

class HomePage extends StatelessWidget {
  final HomeController control = Get.put(HomeController(), permanent: true);

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Sección superior con cuentas (fondo verde)
            _buildHeaderSection(context),
            // Contenido scrolleable
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildMainExpensesSection(context),
                    const SizedBox(height: 20),
                    _buildRecentTransactionsSection(context),
                    const SizedBox(height: 80), // Espacio para el nav bar
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => CustomBottomNavBar(
        currentIndex: control.currentNavIndex.value,
        onTap: (index) => control.changeNavIndex(index, context),
      )),
    );
  }

  Widget _buildHardcodedMainExpenses() {
    // Ejemplo de gastos principales hardcodeados
    final List<Map<String, dynamic>> gastos = [
      {'categoria': 'Comida', 'monto': 120.50, 'fecha': '2025-10-10'},
      {'categoria': 'Transporte', 'monto': 60.00, 'fecha': '2025-10-12'},
      {'categoria': 'Entretenimiento', 'monto': 45.75, 'fecha': '2025-10-14'},
    ];
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      color: const Color(0xFFF8FBFC),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Gastos principales',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.more_horiz, color: Colors.grey[600]),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'ESTE MES',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            ...gastos.map((gasto) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        gasto['categoria'] as String,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'S/ ${(gasto['monto'] as num).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // AppBar eliminado (se quitó el Padding con el botón de configuración)
          
          // Cards de cuentas
          // Se agrega padding superior para dejar espacio desde la parte superior
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 20),
            child: Obx(
              () => SizedBox(
                height: 140,
                child: Center(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: control.accounts.length + 1,
                    itemBuilder: (context, index) {
                      if (index < control.accounts.length) {
                        return _buildAccountCard(context, control.accounts[index]);
                      } else {
                        return _buildAddAccountCard(context);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountCard(BuildContext context, Map<String, dynamic> account) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.account_balance_wallet_outlined,
              color: colorScheme.primary,
              size: 24,
            ),
          ),
          const Spacer(),
          Text(
            account['name'],
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${account['amount'].toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            account['currency'],
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddAccountCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => control.addAccount(context),
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: colorScheme.onPrimary,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Agregar cuenta',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainExpensesSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final List<Map<String, dynamic>> gastos = [
      {'categoria': 'Comida', 'monto': 120.50, 'fecha': '2025-10-10'},
      {'categoria': 'Transporte', 'monto': 60.00, 'fecha': '2025-10-12'},
      {'categoria': 'Entretenimiento', 'monto': 45.75, 'fecha': '2025-10-14'},
    ];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Gastos principales',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => control.openExpensesMenu(),
                icon: const Icon(Icons.more_horiz),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'ESTE MES',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          ...gastos.map((gasto) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      gasto['categoria'] as String,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'S/ ${(gasto['monto'] as num).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => control.showMoreExpenses(),
              child: Text(
                'Mostrar más',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactionsSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Últimos registros',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => control.openTransactionsMenu(),
                icon: const Icon(Icons.more_horiz),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Obx(
            () {
              final mostrarTodos = control.mostrarTodosRegistros.value;
              final total = control.transactions.length;
              final mostrar = mostrarTodos ? total : (total > 3 ? 3 : total);
              final transaccionesOrdenadas = List<Map<String, dynamic>>.from(control.transactions);
              transaccionesOrdenadas.sort((a, b) {
                final dateA = a['dateTime'] as DateTime? ?? DateTime(1900);
                final dateB = b['dateTime'] as DateTime? ?? DateTime(1900);
                return dateB.compareTo(dateA);
              });
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: mostrar,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildTransactionItem(context, transaccionesOrdenadas[index]);
                },
              );
            },
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Obx(() {
              final total = control.transactions.length;
              if (total <= 3) return const SizedBox.shrink();
              return TextButton(
                onPressed: () => control.showMoreTransactions(),
                child: Text(
                  control.mostrarTodosRegistros.value ? 'Mostrar menos' : 'Mostrar más',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, Map<String, dynamic> transaction) {
    final isIncome = transaction['type'] == 'income';
    final amountColor = isIncome ? Colors.green : Colors.red;

    return Row(
      children: [
        // Ícono circular
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Color(transaction['color']).withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isIncome ? Icons.arrow_downward : Icons.restaurant,
            color: Color(transaction['color']),
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        
        // Título y subtítulo
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              Text(
                transaction['subtitle'],
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        
        // Monto y fecha
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${isIncome ? '+' : ''}S/ ${transaction['amount'].toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: amountColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              transaction['date'],
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}