# Forms

## Rules

- Reuse the repository's established form library and field adapters.
- When no form solution exists, prefer React Hook Form for submitted, validated, multi-field, dirty, or
  error-tracked input. Add it only when dependency changes are within scope; otherwise propose it and
  explain why local state is insufficient.
- Local state is allowed only for a single lightweight search, filter, or instant control without form lifecycle.
- Never mirror form values in component state.
- With React Hook Form, use `register` for ref-compatible inputs and `Controller` or `useController` for
  controlled fields.
- Reuse the repository's compatible field integration. Otherwise use a maintained recommended integration or a thin adapter.
- The selected form layer owns the draft. The server-state layer owns submitted data.

## Example

```tsx
const { control, register, handleSubmit } = useForm<Values>({ defaultValues });

<input {...register("email", { required: "Required" })} />

<Controller
  control={control}
  name="country"
  rules={{ required: "Required" }}
  render={({ field, fieldState }) => (
    <Select {...field} error={!!fieldState.error} helperText={fieldState.error?.message} />
  )}
/>
```

## Check

Test validation, submission, backend errors, dirty state, reset, and pending behavior that apply.
