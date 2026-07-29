# Forms

## Rules

- Use React Hook Form for submitted, validated, multi-field, dirty, or error-tracked input.
- If missing, install a React-compatible version with the repository's package manager.
- Local state is allowed only for a single lightweight search, filter, or instant control without form lifecycle.
- Never mirror form values in component state.
- Use `register` for ref-compatible inputs.
- Use `Controller` or `useController` for controlled fields.
- Reuse the repository's compatible field integration. Otherwise use a maintained recommended integration or a thin adapter.
- React Hook Form owns the draft. The server-state layer owns submitted data.

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
