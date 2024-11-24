<?php

namespace App\Filament\Resources\IngredientsResource\Pages;

use App\Filament\Resources\IngredientsResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListIngredients extends ListRecords
{
    protected static string $resource = IngredientsResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}