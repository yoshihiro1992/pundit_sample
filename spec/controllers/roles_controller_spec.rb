require 'spec_helper'

describe RolesController do
  let(:only_view_role) { FG.create(:only_view_role) }

  let(:foo_index) { FG.create(:foo_index) }
  let(:foo_show) { FG.create(:foo_show) }
  let(:foo_create) { FG.create(:foo_create) }
  let(:foo_update) { FG.create(:foo_update) }
  let(:foo_destroy) { FG.create(:foo_destroy) }

  let(:valid_attributes) do
    {
      "name" => "foo権限保持者",
      "roles_abilities_attributes" => [
        { "ability_id" => foo_index.to_param },
        { "ability_id" => foo_show.to_param },
        { "ability_id" => foo_create.to_param }
      ]
    }
  end

  let(:all_update) do
    {
      "name" => "名前変更",
      "roles_abilities_attributes" => [
        { "ability_id" => foo_index.to_param },
        { "ability_id" => foo_show.to_param }
      ]
    }
  end

  let(:some_update) do
    {
      "name" => "名前変更",
      "roles_abilities_attributes" => [
        { "ability_id" => only_view_role.roles_abilities[0].ability_id },
        { "ability_id" => only_view_role.roles_abilities[1].ability_id },
        { "ability_id" => only_view_role.roles_abilities[2].ability_id },
        { "ability_id" => foo_index.to_param }
      ]
    }
  end

  let(:not_update) do
    {
      "roles_abilities_attributes" => [
        { "ability_id" => only_view_role.roles_abilities[0].ability_id },
        { "ability_id" => only_view_role.roles_abilities[1].ability_id },
        { "ability_id" => only_view_role.roles_abilities[2].ability_id },
        { "ability_id" => only_view_role.roles_abilities[3].ability_id },
      ]
    }
  end

  #
  # index
  #
  describe 'GET /roles', '#index' do
    context '管理者' do
      include_context "管理者でログイン"
      it_behaves_like "Role indexができる"
    end

    context '権限保持者' do
      include_context "Role権限保持者でログイン"
      it_behaves_like "Role indexができる"
    end

    context '権限非保持者' do
      include_context "User権限保持者でログイン"
      it_behaves_like "Role indexができない"
    end
  end

  #
  # show
  #
  describe 'GET /roles/:id', '#show' do
    context '管理者' do
      include_context "管理者でログイン"
      it_behaves_like "Role showができる"
    end

    context '権限保持者' do
      include_context "Role権限保持者でログイン"
      it_behaves_like "Role showができる"
    end

    context '権限非保持者' do
      include_context "User権限保持者でログイン"
      it_behaves_like "Role showができない"
    end
  end

  #
  # new
  #
  describe 'GET /roles/new', '#new' do
    context '管理者' do
      include_context "管理者でログイン"
      it_behaves_like "Role newができる"
    end

    context '権限保持者' do
      include_context "Role権限保持者でログイン"
      it_behaves_like "Role newができる"
    end

    context '権限非保持者' do
      include_context "User権限保持者でログイン"
      it_behaves_like "Role newができない"
    end
  end

  #
  # edit
  #
  describe 'GET /roles/:id/edit', '#edit' do
    context '管理者' do
      include_context "管理者でログイン"
      it_behaves_like "Role editができる"
    end

    context '権限保持者' do
      include_context "Role権限保持者でログイン"
      it_behaves_like "Role editができる"
    end

    context '権限非保持者' do
      include_context "User権限保持者でログイン"
      it_behaves_like "Role editができない"
    end
  end

  #
  # create
  #
  describe 'POST /roles', '#create' do
    context '管理者' do
      include_context "管理者でログイン"
      it_behaves_like "Role createができる"
    end

    context '権限保持者' do
      include_context "Role権限保持者でログイン"
      it_behaves_like "Role createができる"
    end

    context '権限非保持者' do
      include_context "User権限保持者でログイン"
      it_behaves_like "Role createができない"
    end
  end

  #
  # update
  #
  describe 'PATCH/PUT /roles/:id', '#update' do
    context '管理者' do
      include_context "管理者でログイン"
      it_behaves_like "Role updateができる"
    end

    context '権限保持者' do
      include_context "Role権限保持者でログイン"
      it_behaves_like "Role updateができる"
    end

    context '権限非保持者' do
      include_context "User権限保持者でログイン"
      it_behaves_like "Role updateができない"
    end
  end

  #
  # destroy
  #
  describe 'DELETE /roles/:id', '#destroy' do
    context '管理者' do
      include_context "管理者でログイン"
      it_behaves_like "Role destroyができる"
    end

    context '権限保持者' do
      include_context "Role権限保持者でログイン"
      it_behaves_like "Role destroyができる"
    end

    context '権限非保持者' do
      include_context "User権限保持者でログイン"
      it_behaves_like "Role destroyができない"
    end
  end
end
