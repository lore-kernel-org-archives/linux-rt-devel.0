Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E61D471D12
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Jul 2026 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813037; cv=none; b=asXc/PV5bPP57ge3SmwxHsJcYDZYSaej/jJnhVcOdFw2Kk2Dv1ohzYVWpo8puY3WFL9I9xQYoDL104Zil34wtvHj7PXnxz6ips+20DqbyzfRrHe3MqqjiLYpouMtru2xvyhkz84qtJN6zAHwCSvffFeHHMatNuMUjr6gDxJzJAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813037; c=relaxed/simple;
	bh=ZK0vRvv814h7NsvkegEf8tgNc7j/3vrkKUnFA/12xb4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yw3Je4xCNXc4+DyDI7yChbmnVdjKZyxw2QRaMAyKqZ9wE+s3W41mvYpqRwZ4vQUDibcln/g1i0LifsH4y868oCzHFz81qZvUFrfGdKeLnPtGT3VmXhBj+sxoz4TadEu6YKfxfpUPSr4UPBWh+2UqWOYyhAM0fX2idtRhzxIainc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=hEL0345Z; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="hEL0345Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784813000; x=1785417800; i=spasswolf@web.de;
	bh=h1G172Wbfq5Nqo8SH5tpgVdYNXUQ7xzhdTX/Yx3s+Os=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hEL0345ZCR+KRCy2XKkcAzHM1VyWKeAcqDHfU3asCQPI/88ro2Lek3ndRgcUVDo+
	 naKWExLXGs2GWivknhkgML4fFvl1+rN8yMrhHak+cTvcQDg6jDI5MT4AnfebILzVy
	 UEL3ApqdkP1/4ECGmyFpDON5i/ka+xiKeT1gpwjRsy9JPbHfsUl9hNZ7DAmRaxJ+m
	 BcZnhBwHxRK4sLDm0osI8Q8WAL4+GwY6K6PiQRpbxEmuFrU2GfhtFdYMX80xMIBb4
	 NKxIPPzGVmYbEsITQ2O4294x08Snt4IyfGDQgOsX9pA10g5yitv0r/o7JPqHIrG8c
	 jFzUfWTF/37bFnwQ2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N30ZL-1wzVfZ2ah3-00sm0z; Thu, 23
 Jul 2026 15:23:20 +0200
Message-ID: <d24a136539c5931984f4855ad6596ca7aee8ebe2.camel@web.de>
Subject: Re: [Re] kernel panic during shutdown in v7.2-rc{3,4} and
 next-20260722 with PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org, Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner	 <tglx@linutronix.de>,
 spasswolf@web.de
Date: Thu, 23 Jul 2026 15:23:19 +0200
In-Reply-To: <20260723131001.11565-1-spasswolf@web.de>
References: <20260723131001.11565-1-spasswolf@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HDXwAzK+odJYOo++iTc2jLMMqJTM8Nv2uFVqQK5pPQ7o+sDoHmA
 /HyRh2B9WVgdVQLY2r4SSucfGb4CWA+tUp58LSOMqMkzcslHdIj05jK8OeqczZyTNwkYusM
 NVUherRpf0NmK7wMaM1CkgUq1aJrURXizmYIutR8oDw8ny0K2dcd91HmBpnIKlu+WvNQNra
 psII8m988FcGfpPGP/5hQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+GnoH5/lZ10=;zUNWzszV6Dhc8whIlKRl5tiyPPb
 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
 5gjcvji530eF

Am Donnerstag, dem 23.07.2026 um 15:10 +0200 schrieb Bert Karwatzki:
> I was able to gather the panic error message from a failed shutdown via =
netconsole,
> this time the kernel used was v7.2-rc3:
> #
> Bert Karwatzki

Unfortunatetly I can now reproduce these kernel panics in v7.1:

T1581;BUG: scheduling while atomic: Xorg/1581/0x00000003
T1581,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e m=
t7925_common
snd_usbmidi_lib mt792x_lib snd_ump mt76_connac_lib snd_rawmidi mt76 snd_se=
q_device intel_rapl_msr iosf_mbi intel_rapl_common snd_hda_codec_atihdmi m=
ac80211 rapl
wmi_bmof snd_hda_codec_hdmi snd_hda_intel snd_hda_codec pcspkr libarc4 snd=
_hda_core cfg80211 snd_intel_dspcfg snd_hwdep snd_pcm snd_timer snd rfkill=
 soundcore
aead evdev spd5118 regmap_i2c ccp k10temp nct6775 nct6775_core hwmon_vid c=
onfigfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 amdgpu hid_generic
drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper ttm usbhid drm_exec d=
rm_suballoc_helper mfd_core hid drm_panel_backlight_quirks gpu_sched amdxc=
p
drm_display_helper drm_kms_helper ahci libahci xhci_pci drm libata xhci_hc=
d nvme scsi_mod usbcore igc nvme_core video cec scsi_common nvme_keyring c=
rc16
nvme_auth i2c_piix4 gpio_amdpt usb_common i2c
T1581,ncfrag=3D955/979;_smbus gpio_generic wmi
T1581;CPU: 19 UID: 0 PID: 1581 Comm: Xorg Not tainted 7.1.0-stable #1241 P=
REEMPT_{RT,(full)}=20
T1581;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1581;Call Trace:
T1581; <TASK>
T1581; ? dump_stack_lvl+0x4b/0x70
T1581; ? __schedule_bug.cold+0x3e/0x4a
T1581; ? __schedule+0xf6f/0x1700
T1581; ? try_to_take_rt_mutex+0x191/0x300
T1581; ? rtlock_slowlock_locked+0x39/0xe50
T1581; ? schedule_rtlock+0x15/0x30
T1581; ? rtlock_slowlock_locked+0x30b/0xe50
T1581; ? rt_spin_lock+0xc3/0x120
T1581; ? get_page_from_freelist+0x221/0x15f0
T1581; ? dc_link_get_highest_encoding_format+0x61/0xb0 [amdgpu]
T1581; ? __alloc_frozen_pages_noprof+0x146/0x2b0
T1581; ? ___kmalloc_large_node+0xae/0xd0
T1581; ? __kvmalloc_node_noprof+0x398/0x540
T1581; ? dcn401_build_pipe_pix_clk_params+0x10a/0x1f0 [amdgpu]
T1581; ? dc_create_plane_state+0x24/0x80 [amdgpu]
T1581; ? dc_state_create_phantom_plane+0x15/0x50 [amdgpu]
T1581; ? dml21_handle_phantom_streams_planes+0x292/0x510 [amdgpu]
T1581; ? dml21_mode_check_and_programming+0x157/0x7e0 [amdgpu]
T1581; ? sysvec_call_function_single+0xe/0x80
T1581; ? asm_sysvec_call_function_single+0x1a/0x20
T1581; ? try_to_take_rt_mutex+0x191/0x300
T1581; ? calculate_plane_rec_in_timing_active+0x142/0x1f0 [amdgpu]
T1581; ? spl_calculate_number_of_taps.constprop.0.isra.0+0x142/0xf00 [amdg=
pu]
T1581; ? spl_calculate_number_of_taps.constprop.0.isra.0+0xed4/0xf00 [amdg=
pu]
T1581; ? dcn401_validate_bandwidth+0xb8/0x1f0 [amdgpu]
T1581; ? dc_validate_with_context+0x5cf/0x6b0 [amdgpu]
T1581; ? dc_commit_streams+0x27c/0x4e0 [amdgpu]
T1581; ? amdgpu_dm_atomic_commit_tail+0x4ec/0x3610 [amdgpu]
T1581; ? optc1_get_crtc_scanoutpos+0x5f/0xa0 [amdgpu]
T1581; ? dc_stream_get_scanoutpos+0x7a/0xc0 [amdgpu]
T1581; ? amdgpu_display_get_crtc_scanoutpos+0xa5/0x1c0 [amdgpu]
T1581; ? amdgpu_display_crtc_idx_to_irq_type+0x30/0x30 [amdgpu]
T1581; ? amdgpu_crtc_get_scanout_position+0x23/0x30 [amdgpu]
T1581; ? drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x176/0x3a0 =
[drm]
T1581; ? wait_for_completion_timeout+0x127/0x170
T1581; ? drm_crtc_get_last_vbltimestamp+0x50/0x80 [drm]
T1581; ? commit_tail+0xad/0x140 [drm_kms_helper]
T1581; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1581; ? drm_atomic_commit+0xac/0xe0 [drm]
T1581; ? __drm_universal_plane_init.cold+0x12/0x12 [drm]
T1581; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1581; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1581; ? __schedule+0x389/0x1700
T1581; ? rt_spin_lock+0x35/0x120
T1581; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1581; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1581; ? drm_ioctl+0x27f/0x520 [drm]
T1581; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1581; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1581; ? __x64_sys_ioctl+0x92/0xe0
T1581; ? do_syscall_64+0xdd/0x5d0
T1581; ? switch_fpu_return+0x42/0x70
T1581; ? handle_irq_event+0x4c/0x80
T1581; ? do_syscall_64+0x94/0x5d0
T1581; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1581; </TASK>
T1581;------------[ cut here ]------------
T1581;WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:12=
6 at dc_fpu_end+0x36/0x40 [amdgpu], CPU#20: Xorg/1581
T1581,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e m=
t7925_common
snd_usbmidi_lib mt792x_lib snd_ump mt76_connac_lib snd_rawmidi mt76 snd_se=
q_device intel_rapl_msr iosf_mbi intel_rapl_common snd_hda_codec_atihdmi m=
ac80211 rapl
wmi_bmof snd_hda_codec_hdmi snd_hda_intel snd_hda_codec pcspkr libarc4 snd=
_hda_core cfg80211 snd_intel_dspcfg snd_hwdep snd_pcm snd_timer snd rfkill=
 soundcore
aead evdev spd5118 regmap_i2c ccp k10temp nct6775 nct6775_core hwmon_vid c=
onfigfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 amdgpu hid_generic
drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper ttm usbhid drm_exec d=
rm_suballoc_helper mfd_core hid drm_panel_backlight_quirks gpu_sched amdxc=
p
drm_display_helper drm_kms_helper ahci libahci xhci_pci drm libata xhci_hc=
d nvme scsi_mod usbcore igc nvme_core video cec scsi_common nvme_keyring c=
rc16
nvme_auth i2c_piix4 gpio_amdpt usb_common i2c
T1581,ncfrag=3D955/979;_smbus gpio_generic wmi
T1581;CPU: 20 UID: 0 PID: 1581 Comm: Xorg Tainted: G        W           7.=
1.0-stable #1241 PREEMPT_{RT,(full)}=20
T1581;Tainted: [W]=3DWARN
T1581;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1581;RIP: 0010:dc_fpu_end+0x36/0x40 [amdgpu]
T1581;Code: 05 0f 2b f7 d6 ff c8 74 10 78 1f 65 ff 0d 32 1b f6 d6 74 0c c3=
 cc cc cc cc e8 96 f7 f2 d5 eb eb e8 4f 65 f1 d5 c3 cc cc cc cc <0f> 0b eb=
 dd 66 0f 1f
44 00 00 41 56 41 55 41 54 55 53 48 83 ec 10
T1581;RSP: 0018:ffff9d3305d835b8 EFLAGS: 00010296
T1581;RAX: 00000000ffffffff RBX: ffff8face4600000 RCX: 0000000000000008
T1581;RDX: 0000000000000000 RSI: 00000000000006a4 RDI: ffffffffc15999d0
T1581;RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
T1581;R10: ffff8face4600000 R11: 0000000000000002 R12: ffff8fac0d6c0000
T1581;R13: ffff8faca1000000 R14: 0000000000000000 R15: ffff8faca1000000
T1581;FS:  00007ff40af34b80(0000) GS:ffff8fbba5c76000(0000) knlGS:00000000=
00000000
T1581;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
T1581;CR2: 0000559cb13d5018 CR3: 0000000120bd9000 CR4: 0000000000f50ef0
T1581;PKRU: 55555554
T1581;Call Trace:
T1581; <TASK>
T1581; ? dcn401_validate_bandwidth+0xd1/0x1f0 [amdgpu]
T1581; ? dc_validate_with_context+0x5cf/0x6b0 [amdgpu]
T1581; ? dc_commit_streams+0x27c/0x4e0 [amdgpu]
T1581; ? amdgpu_dm_atomic_commit_tail+0x4ec/0x3610 [amdgpu]
T1581; ? optc1_get_crtc_scanoutpos+0x5f/0xa0 [amdgpu]
T1581; ? dc_stream_get_scanoutpos+0x7a/0xc0 [amdgpu]
T1581; ? amdgpu_display_get_crtc_scanoutpos+0xa5/0x1c0 [amdgpu]
T1581; ? amdgpu_display_crtc_idx_to_irq_type+0x30/0x30 [amdgpu]
T1581; ? amdgpu_crtc_get_scanout_position+0x23/0x30 [amdgpu]
T1581; ? drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x176/0x3a0 =
[drm]
T1581; ? wait_for_completion_timeout+0x127/0x170
T1581; ? drm_crtc_get_last_vbltimestamp+0x50/0x80 [drm]
T1581; ? commit_tail+0xad/0x140 [drm_kms_helper]
T1581; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1581; ? drm_atomic_commit+0xac/0xe0 [drm]
T1581; ? __drm_universal_plane_init.cold+0x12/0x12 [drm]
T1581; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1581; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1581; ? __schedule+0x389/0x1700
T1581; ? rt_spin_lock+0x35/0x120
T1581; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1581; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1581; ? drm_ioctl+0x27f/0x520 [drm]
T1581; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1581; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1581; ? __x64_sys_ioctl+0x92/0xe0
T1581; ? do_syscall_64+0xdd/0x5d0
T1581; ? switch_fpu_return+0x42/0x70
T1581; ? handle_irq_event+0x4c/0x80
T1581; ? do_syscall_64+0x94/0x5d0
T1581; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1581; </TASK>
T1581;---[ end trace 0000000000000000 ]---
T1581;------------[ cut here ]------------
T1581;WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:97=
 at dc_fpu_begin+0x4f/0x60 [amdgpu], CPU#1: Xorg/1581
T1581,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e m=
t7925_common
snd_usbmidi_lib mt792x_lib snd_ump mt76_connac_lib snd_rawmidi mt76 snd_se=
q_device intel_rapl_msr iosf_mbi intel_rapl_common snd_hda_codec_atihdmi m=
ac80211 rapl
wmi_bmof snd_hda_codec_hdmi snd_hda_intel snd_hda_codec pcspkr libarc4 snd=
_hda_core cfg80211 snd_intel_dspcfg snd_hwdep snd_pcm snd_timer snd rfkill=
 soundcore
aead evdev spd5118 regmap_i2c ccp k10temp nct6775 nct6775_core hwmon_vid c=
onfigfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 amdgpu hid_generic
drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper ttm usbhid drm_exec d=
rm_suballoc_helper mfd_core hid drm_panel_backlight_quirks gpu_sched amdxc=
p
drm_display_helper drm_kms_helper ahci libahci xhci_pci drm libata xhci_hc=
d nvme scsi_mod usbcore igc nvme_core video cec scsi_common nvme_keyring c=
rc16
nvme_auth i2c_piix4 gpio_amdpt usb_common i2c
T1581,ncfrag=3D955/979;_smbus gpio_generic wmi
T1581;CPU: 1 UID: 0 PID: 1581 Comm: Xorg Tainted: G        W           7.1=
.0-stable #1241 PREEMPT_{RT,(full)}=20
T1581;Tainted: [W]=3DWARN
T1581;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1581;RIP: 0010:dc_fpu_begin+0x4f/0x60 [amdgpu]
T1581;Code: d0 75 27 65 ff 05 81 1b f6 d6 b8 01 00 00 00 65 0f c1 05 44 2b=
 f7 d6 85 c0 74 05 c3 cc cc cc cc bf 02 00 00 00 e9 51 f8 f2 d5 <0f> 0b eb=
 d5 66 90 66
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 d6 b8
T1581;RSP: 0018:ffff9d3305d83640 EFLAGS: 00010206
T1581;RAX: 0000000000ff0000 RBX: ffff8fad48480000 RCX: ffff8face86d3e28
T1581;RDX: 0000000000ff0000 RSI: 000000000000011f RDI: ffffffffc15bcda0
T1581;RBP: ffff8fad65380000 R08: ffffffff97b01fc0 R09: 0000000000000006
T1581;R10: ffffffff97cb5440 R11: 0000000000000076 R12: ffff8fad48480000
T1581;R13: 0000000000000001 R14: ffff8faca1000000 R15: 0000000000000000
T1581;FS:  00007ff40af34b80(0000) GS:ffff8fbba57b6000(0000) knlGS:00000000=
00000000
T1581;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
T1581;CR2: 00007f593eec2478 CR3: 0000000120bd9000 CR4: 0000000000f50ef0
T1581;PKRU: 55555554
T1581;Call Trace:
T1581; <TASK>
T1581; ? dc_state_create_copy+0x76/0x120 [amdgpu]
T1581; ? dc_commit_state_no_check+0x271/0xde0 [amdgpu]
T1581; ? dc_commit_streams+0x2f4/0x4e0 [amdgpu]
T1581; ? amdgpu_dm_atomic_commit_tail+0x4ec/0x3610 [amdgpu]
T1581; ? optc1_get_crtc_scanoutpos+0x5f/0xa0 [amdgpu]
T1581; ? dc_stream_get_scanoutpos+0x7a/0xc0 [amdgpu]
T1581; ? amdgpu_display_get_crtc_scanoutpos+0xa5/0x1c0 [amdgpu]
T1581; ? amdgpu_display_crtc_idx_to_irq_type+0x30/0x30 [amdgpu]
T1581; ? amdgpu_crtc_get_scanout_position+0x23/0x30 [amdgpu]
T1581; ? drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x176/0x3a0 =
[drm]
T1581; ? wait_for_completion_timeout+0x127/0x170
T1581; ? drm_crtc_get_last_vbltimestamp+0x50/0x80 [drm]
T1581; ? commit_tail+0xad/0x140 [drm_kms_helper]
T1581; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1581; ? drm_atomic_commit+0xac/0xe0 [drm]
T1581; ? __drm_universal_plane_init.cold+0x12/0x12 [drm]
T1581; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1581; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1581; ? __schedule+0x389/0x1700
T1581; ? rt_spin_lock+0x35/0x120
T1581; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1581; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1581; ? drm_ioctl+0x27f/0x520 [drm]
T1581; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1581; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1581; ? __x64_sys_ioctl+0x92/0xe0
T1581; ? do_syscall_64+0xdd/0x5d0
T1581; ? switch_fpu_return+0x42/0x70
T1581; ? handle_irq_event+0x4c/0x80
T1581; ? do_syscall_64+0x94/0x5d0
T1581; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1581; </TASK>
T1581;---[ end trace 0000000000000000 ]---
T1581;------------[ cut here ]------------
T1581;kernel BUG at mm/vmalloc.c:3206!
T1581;Oops: invalid opcode: 0000 [#1] SMP NOPTI
T1581;CPU: 29 UID: 0 PID: 1581 Comm: Xorg Tainted: G        W           7.=
1.0-stable #1241 PREEMPT_{RT,(full)}=20
T1581;Tainted: [W]=3DWARN
T1581;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1581;RIP: 0010:__get_vm_area_node+0x113/0x130
T1581;Code: ff bd ff ff ff ff 48 0f bd e8 b8 0c 00 00 00 ff c5 39 c5 0f 4c=
 e8 b8 1e 00 00 00 39 c5 0f 4f e8 c4 e2 d1 f7 ee e9 34 ff ff ff <0f> 0b 4c=
 89 ef e8 23
51 01 00 45 31 ed eb ae 0f 1f 00 66 66 2e 0f
T1581;RSP: 0018:ffff9d3305d834f8 EFLAGS: 00010286
T1581;RAX: 00000000ffffffff RBX: 0000000000000001 RCX: 0000000000000022
T1581;RDX: 000000000000000c RSI: 0000000000000001 RDI: 000000000000f720
T1581;RBP: 000000000000000c R08: ffff9d3300000000 R09: ffffbd32ffffffff
T1581;R10: 00000000ffffffff R11: 0000000000000076 R12: ffff8fad48480000
T1581;R13: 0000000000000001 R14: 0000000000000dc0 R15: 000000000000f720
T1581;FS:  00007ff40af34b80(0000) GS:ffff8fbba5eb6000(0000) knlGS:00000000=
00000000
T1581;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
T1581;CR2: 00007f6ae0f90110 CR3: 0000000120bd9000 CR4: 0000000000f50ef0
T1581;PKRU: 55555554
T1581;Call Trace:
T1581; <TASK>
T1581; ? __vmalloc_node_range_noprof+0x14a/0x920
T1581; ? dml21_allocate_memory+0x124/0x180 [amdgpu]
T1581; ? dml21_allocate_memory+0x124/0x180 [amdgpu]
T1581; ? exc_invalid_op+0x18/0x70
T1581; ? __vmalloc_node_noprof+0x47/0x60
T1581; ? dml21_allocate_memory+0x124/0x180 [amdgpu]
T1581; ? dml21_allocate_memory+0x124/0x180 [amdgpu]
T1581; ? dml21_create_copy+0x16/0x40 [amdgpu]
T1581; ? dc_state_create_copy+0x89/0x120 [amdgpu]
T1581; ? dc_commit_state_no_check+0x271/0xde0 [amdgpu]
T1581; ? dc_commit_streams+0x2f4/0x4e0 [amdgpu]
T1581; ? amdgpu_dm_atomic_commit_tail+0x4ec/0x3610 [amdgpu]
T1581; ? optc1_get_crtc_scanoutpos+0x5f/0xa0 [amdgpu]
T1581; ? dc_stream_get_scanoutpos+0x7a/0xc0 [amdgpu]
T1581; ? amdgpu_display_get_crtc_scanoutpos+0xa5/0x1c0 [amdgpu]
T1581; ? amdgpu_display_crtc_idx_to_irq_type+0x30/0x30 [amdgpu]
T1581; ? amdgpu_crtc_get_scanout_position+0x23/0x30 [amdgpu]
T1581; ? drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x176/0x3a0 =
[drm]
T1581; ? wait_for_completion_timeout+0x127/0x170
T1581; ? drm_crtc_get_last_vbltimestamp+0x50/0x80 [drm]
T1581; ? commit_tail+0xad/0x140 [drm_kms_helper]
T1581; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1581; ? drm_atomic_commit+0xac/0xe0 [drm]
T1581; ? __drm_universal_plane_init.cold+0x12/0x12 [drm]
T1581; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1581; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1581; ? __schedule+0x389/0x1700
T1581; ? rt_spin_lock+0x35/0x120
T1581; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1581; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1581; ? drm_ioctl+0x27f/0x520 [drm]
T1581; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1581; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1581; ? __x64_sys_ioctl+0x92/0xe0
T1581; ? do_syscall_64+0xdd/0x5d0
T1581; ? switch_fpu_return+0x42/0x70
T1581; ? handle_irq_event+0x4c/0x80
T1581; ? do_syscall_64+0x94/0x5d0
T1581; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1581; </TASK>
T1581,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e m=
t7925_common
snd_usbmidi_lib mt792x_lib snd_ump mt76_connac_lib snd_rawmidi mt76 snd_se=
q_device intel_rapl_msr iosf_mbi intel_rapl_common snd_hda_codec_atihdmi m=
ac80211 rapl
wmi_bmof snd_hda_codec_hdmi snd_hda_intel snd_hda_codec pcspkr libarc4 snd=
_hda_core cfg80211 snd_intel_dspcfg snd_hwdep snd_pcm snd_timer snd rfkill=
 soundcore
aead evdev spd5118 regmap_i2c ccp k10temp nct6775 nct6775_core hwmon_vid c=
onfigfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 amdgpu hid_generic
drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper ttm usbhid drm_exec d=
rm_suballoc_helper mfd_core hid drm_panel_backlight_quirks gpu_sched amdxc=
p
drm_display_helper drm_kms_helper ahci libahci xhci_pci drm libata xhci_hc=
d nvme scsi_mod usbcore igc nvme_core video cec scsi_common nvme_keyring c=
rc16
nvme_auth i2c_piix4 gpio_amdpt usb_common i2c
T1581,ncfrag=3D955/979;_smbus gpio_generic wmi
T1581;---[ end trace 0000000000000000 ]---
T1581;------------[ cut here ]------------
T1581;WARNING: kernel/printk/nbcon.c:1739 at nbcon_cpu_emergency_exit+0x85=
/0xa0, CPU#26: Xorg/1581
T1581,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e m=
t7925_common
snd_usbmidi_lib mt792x_lib snd_ump mt76_connac_lib snd_rawmidi mt76 snd_se=
q_device intel_rapl_msr iosf_mbi intel_rapl_common snd_hda_codec_atihdmi m=
ac80211 rapl
wmi_bmof snd_hda_codec_hdmi snd_hda_intel snd_hda_codec pcspkr libarc4 snd=
_hda_core cfg80211 snd_intel_dspcfg snd_hwdep snd_pcm snd_timer snd rfkill=
 soundcore
aead evdev spd5118 regmap_i2c ccp k10temp nct6775 nct6775_core hwmon_vid c=
onfigfs efi_pstore efivarfs autofs4 ext4 mbcache jbd2 amdgpu hid_generic
drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper ttm usbhid drm_exec d=
rm_suballoc_helper mfd_core hid drm_panel_backlight_quirks gpu_sched amdxc=
p
drm_display_helper drm_kms_helper ahci libahci xhci_pci drm libata xhci_hc=
d nvme scsi_mod usbcore igc nvme_core video cec scsi_common nvme_keyring c=
rc16
nvme_auth i2c_piix4 gpio_amdpt usb_common i2c
T1581,ncfrag=3D955/979;_smbus gpio_generic wmi
T1581;CPU: 26 UID: 0 PID: 1581 Comm: Xorg Tainted: G      D W           7.=
1.0-stable #1241 PREEMPT_{RT,(full)}=20
T1581;Tainted: [D]=3DDIE, [W]=3DWARN
T1581;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1581;RIP: 0010:nbcon_cpu_emergency_exit+0x85/0xa0
T1581;Code: 75 38 48 83 c4 10 c3 cc cc cc cc 48 8d 7c 24 04 e8 e0 ef ff ff=
 80 7c 24 05 00 74 ce e8 74 fc ff ff eb c7 e8 0d 86 f2 ff eb c9 <0f> 0b 8b=
 05 c3 78 fc
00 85 c0 75 a2 0f 0b eb b0 e8 46 01 8a 00 66
T1581;RSP: 0018:ffff9d3305d83368 EFLAGS: 00010246
T1581;RAX: 0000000000000000 RBX: 000000000000000b RCX: 0000000000000000
T1581;RDX: ffff8fbb3da9b3c4 RSI: 0000000000000001 RDI: ffff8fbb3da9b200
T1581;RBP: 0000000000000246 R08: 0000000000000000 R09: 3fffffffffffdfff
T1581;R10: ffffffff97cd3dc0 R11: ffff9d3305d83170 R12: ffff9d3305d83448
T1581;R13: ffffffff96ec5913 R14: 0000000000000002 R15: 0000000000000004
T1581;FS:  00007ff40af34b80(0000) GS:ffff8fbba5df6000(0000) knlGS:00000000=
00000000
T1581;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
T1581;CR2: 00007f4d92ce39d0 CR3: 0000000120bd9000 CR4: 0000000000f50ef0
T1581;PKRU: 55555554
T1581;Call Trace:
T1581; <TASK>
T1581; ? oops_exit.cold+0x13/0x1f
T1581; ? oops_end+0x66/0xe0
T1581; ? do_trap+0xc5/0x110
T1581; ? do_error_trap+0x60/0x80
T1581; ? __get_vm_area_node+0x113/0x130
T1581; ? exc_invalid_op+0x4f/0x70
T1581; ? __get_vm_area_node+0x113/0x130
T1581; ? asm_exc_invalid_op+0x1a/0x20
T1581; ? __get_vm_area_node+0x113/0x130
T1581; ? __vmalloc_node_range_noprof+0x14a/0x920
T1581; ? dml21_allocate_memory+0x124/0x180 [amdgpu]
T1581; ? dml21_allocate_memory+0x124/0x180 [amdgpu]
T1581; ? exc_invalid_op+0x18/0x70
T1581; ? __vmalloc_node_noprof+0x47/0x60
T1581; ? dml21_allocate_memory+0x124/0x180 [amdgpu]
T1581; ? dml21_allocate_memory+0x124/0x180 [amdgpu]
T1581; ? dml21_create_copy+0x16/0x40 [amdgpu]
T1581; ? dc_state_create_copy+0x89/0x120 [amdgpu]
T1581; ? dc_commit_state_no_check+0x271/0xde0 [amdgpu]
T1581; ? dc_commit_streams+0x2f4/0x4e0 [amdgpu]
T1581; ? amdgpu_dm_atomic_commit_tail+0x4ec/0x3610 [amdgpu]
T1581; ? optc1_get_crtc_scanoutpos+0x5f/0xa0 [amdgpu]
T1581; ? dc_stream_get_scanoutpos+0x7a/0xc0 [amdgpu]
T1581; ? amdgpu_display_get_crtc_scanoutpos+0xa5/0x1c0 [amdgpu]
T1581; ? amdgpu_display_crtc_idx_to_irq_type+0x30/0x30 [amdgpu]
T1581; ? amdgpu_crtc_get_scanout_position+0x23/0x30 [amdgpu]
T1581; ? drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x176/0x3a0 =
[drm]
T1581; ? wait_for_completion_timeout+0x127/0x170
T1581; ? drm_crtc_get_last_vbltimestamp+0x50/0x80 [drm]
T1581; ? commit_tail+0xad/0x140 [drm_kms_helper]
T1581; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1581; ? drm_atomic_commit+0xac/0xe0 [drm]
T1581; ? __drm_universal_plane_init.cold+0x12/0x12 [drm]
T1581; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1581; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1581; ? __schedule+0x389/0x1700
T1581; ? rt_spin_lock+0x35/0x120
T1581; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1581; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1581; ? drm_ioctl+0x27f/0x520 [drm]
T1581; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1581; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1581; ? __x64_sys_ioctl+0x92/0xe0
T1581; ? do_syscall_64+0xdd/0x5d0
T1581; ? switch_fpu_return+0x42/0x70
T1581; ? handle_irq_event+0x4c/0x80
T1581; ? do_syscall_64+0x94/0x5d0
T1581; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1581; </TASK>
T1581;---[ end trace 0000000000000000 ]---
C19;RIP: 0010:__get_vm_area_node+0x113/0x130
C28;Code: ff bd ff ff ff ff 48 0f bd e8 b8 0c 00 00 00 ff c5 39 c5 0f 4c e=
8 b8 1e 00 00 00 39 c5 0f 4f e8 c4 e2 d1 f7 ee e9 34 ff ff ff <0f> 0b 4c 8=
9 ef e8 23
51 01 00 45 31 ed eb ae 0f 1f 00 66 66 2e 0f
C28;RSP: 0018:ffff9d3305d834f8 EFLAGS: 00010286
C28;RAX: 00000000ffffffff RBX: 0000000000000001 RCX: 0000000000000022
C28;RDX: 000000000000000c RSI: 0000000000000001 RDI: 000000000000f720
C28;RBP: 000000000000000c R08: ffff9d3300000000 R09: ffffbd32ffffffff
C28;R10: 00000000ffffffff R11: 0000000000000076 R12: ffff8fad48480000
C28;R13: 0000000000000001 R14: 0000000000000dc0 R15: 000000000000f720
C28;FS:  00007ff40af34b80(0000) GS:ffff8fbba5e76000(0000) knlGS:0000000000=
000000
C28;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
C28;CR2: 00007f6ae2fa7010 CR3: 0000000120bd9000 CR4: 0000000000f50ef0
C28;PKRU: 55555554
T1581;Kernel panic - not syncing: Fatal exception in interrupt
T1581;Kernel Offset: 0x15a00000 from 0xffffffff81000000 (relocation range:=
 0xffffffff80000000-0xffffffffbfffffff)
T1581;---[ end Kernel panic - not syncing: Fatal exception in interrupt ]-=
=2D-

So now I'm going to use memtest86+ on my machine and then look at the chan=
ges I had in
my userspace as the first error occured on 22.7.2026. Let's hope this does=
 not escalate ...

Bert Karwatzki
