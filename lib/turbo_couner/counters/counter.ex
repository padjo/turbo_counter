defmodule TurboCounter.Counters.Counter do
  import Ecto.Changeset
  defstruct [:name, value: 0]
  @types  %{name: :string, value: :integer}

  def new, do:
    %__MODULE__{}

  def new_changeset(params,counters) do
    {new(),@types}
    |> cast(params, Map.keys(@types))
    |> validate_required(:name)
    |> validate_exclusion(:name, Map.keys(counters), message: "can't be repeated")
    |> validate_length(:name, min: 3, max: 20)

  end

end
