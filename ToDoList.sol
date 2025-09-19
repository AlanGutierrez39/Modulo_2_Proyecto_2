// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/**
    *@title Contrato que crea y administra una lista de tareas
    *@author i3arba - 77 Innovation Labs
    *@notice Este es un contrato simple con fines educativos
    *@custom:security No utilices este código en producción
**/
contract ToDoList {
    ///@notice Struct para almacenar datos relacionados con las tareas
    struct Task {
        string descripcion;
        bool completada;
        uint256 tiempoDeCreacion;
    }
    Task[] public s_tasks;
    
    event ToDoList_TaskCreated(Task task);
    event ToDoList_TaskCompleted(Task task);
    event ToDoList_TaskDeleted(string descripcion, uint256 timestamp);

    function createTask(string memory _descripcion) external {
        Task memory newTask = Task({
            descripcion: _descripcion,
            completada: false,
            tiempoDeCreacion: block.timestamp
        });
        
        s_tasks.push(newTask);

        emit ToDoList_TaskCreated(newTask);
    }

    function getTask(uint256 _index) external view returns (Task memory _task) {
        _task = s_tasks[_index];
    }

    function completeTask(uint256 _index) external {
        s_tasks[_index].completada = true;

        emit ToDoList_TaskCompleted(s_tasks[_index]);
    }

    function deleteTask(string memory _descripcion) external{
        uint256 arrayLength= s_tasks.length;
        for (uint256 i = 0; i < arrayLength; i++) {
            if (keccak256(abi.encodePacked(s_tasks[i].descripcion)) == keccak256(abi.encodePacked(_descripcion))) {
                s_tasks[i] = s_tasks[arrayLength-1];
                s_tasks.pop();
                emit ToDoList_TaskDeleted(_descripcion, block.timestamp);
            }
        }
    }
}
