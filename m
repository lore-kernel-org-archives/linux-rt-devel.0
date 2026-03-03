Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D814D390C98
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Mar 2026 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772579056; cv=none; b=kkNzXRoyb7XbL02b6nMiMch73/5r+/3WDVSfG83hofbanjsde/XnFpmvMQxAe/34OCmGraleZpiulXMMDQORYMosdhrpcVDKwyaWO1gKJDSpkkE/rPlJNn51SZPZYj69YvD9jPgs40M82PC2W+25sTiEALiC4H0L+xO7R2QMtcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772579056; c=relaxed/simple;
	bh=15ShB3tO0/PyNIIYioD+budtX4aA+W2mMADhWknFJLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MN9nO6ouP/OKPEGjh9GHm8Pm3ruPXfZs4Xdw6dEUO7z1Ovk4DMlx/KEg/WDU8xOTfkVczr4Q7uQq7SMsYu0DEsyS/4Mm+9V2XhQ4rJTk6Vzub7YWcLhAWjIGbOR0V3bXs0pno7H3fmPXAfnFOmlNdE0Dy0A13jJ8z9RYyZ8GXEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 937701C2F0;
	Tue,  3 Mar 2026 23:04:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id D433820024;
	Tue,  3 Mar 2026 23:04:02 +0000 (UTC)
Date: Tue, 3 Mar 2026 18:04:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton
 <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand
 <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-rt-devel@lists.linux.dev
Subject: Re: rtmutex deadlock and memory corruption when running gcc
 testsuite in next-20260303
Message-ID: <20260303180434.6ecac68b@gandalf.local.home>
In-Reply-To: <20260303222127.2992-1-spasswolf@web.de>
References: <20260303222127.2992-1-spasswolf@web.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: D433820024
X-Stat-Signature: i3m798q99kenn6a9o4p37g69j7fcgybj
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18yFYnuO0ZilnrYeehgY/UvF0iuUTIhibY=
X-HE-Tag: 1772579042-80184
X-HE-Meta: U2FsdGVkX19bGp0najBocPpQxIQQZ9+3qNkct++HygHtLJsi0PkC4ek/f0xUkPvdhh+JzdIIhc0FkhO1NXSuj4jOcte36khDj6utk5Q/hRZyB+A9lq6KRNheqhKOt7gOOelZzeAl+U/by4S3DwAiXz7bsip2t14BB/vDWjb8tWYnYA9L5pXfDt+fmG0lopYvnURGmKhjbMkMO3cRRZH+m36V7ZopyVrv15YIWLhoscUUVe92IcpMnBTIv/pVz1gD1AsuXFfLU06/CA0fSSCB9g5TaMS2wfghNKKqk1+8Rt5bcjd0wETP0CF7Pis3YHda

On Tue,  3 Mar 2026 23:21:25 +0100
Bert Karwatzki <spasswolf@web.de> wrote:

> I tried building gcc-14 from the debian repositories (fetched via apt-get 
> source gcc-14) on my new and shiny zen5 machine (Cpu: "AMD Ryzen 9 9950X 
> 16-Core Processor) running debian stable/trixie and linux-next-20260303 
> (PREEMPT_RT=y) with the following command:
> 
> $ time dpkg-buildpackage --no-sign -B -nc
> 
> after about ~1.45h, during the testsuite, the following error happens:
> 
> [ 6506.666031] [T3176177] Oops: general protection fault, maybe for address 0x7ffe00b6ff00: 0000 [#1] SMP NOPTI

As the first splat was a general protection fault, it likely killed the
task from the kernel.

> [ 6506.666036] [T3176177] CPU: 29 UID: 1000 PID: 3176177 Comm: sh Not tainted 7.0.0-rc2-next-20260303-master #367 PREEMPT_RT 
> [ 6506.666039] [T3176177] Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI, BIOS 1627 02/05/2026
> [ 6506.666040] [T3176177] RIP: 0010:memset+0xf/0x20
> [ 6506.666046] [T3176177] Code: 44 89 54 17 fe eb 0c 48 83 fa 01 72 06 44 8a 1e 44 88 1f c3 cc cc cc cc 0f 1f 00 f3 0f 1e fa 66 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8 c3 cc cc cc cc 0f 1f 80 00 00 00 00 49 89 fa 40 0f
> [ 6506.666048] [T3176177] RSP: 0018:ffffb18ba99636f0 EFLAGS: 00010246
> [ 6506.666050] [T3176177] RAX: 00007ffe00b6ff00 RBX: ffffb18ba99638e0 RCX: 0000000000000100
> [ 6506.666050] [T3176177] RDX: 0000000000000100 RSI: 0000000000000000 RDI: 622f6564756c636e
> [ 6506.666051] [T3176177] RBP: 00007ffe00b6ffff R08: 0000000000000008 R09: 622f6564756c636e
> [ 6506.666052] [T3176177] R10: 0000000000000008 R11: 0000000000000000 R12: 000000000000000b
> [ 6506.666052] [T3176177] R13: 0000000000000002 R14: 622f6564756c636e R15: ffffb18ba9963850
> [ 6506.666053] [T3176177] FS:  0000000000000000(0000) GS:ffff927393821000(0000) knlGS:0000000000000000
> [ 6506.666054] [T3176177] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6506.666055] [T3176177] CR2: 00007ff936904dd0 CR3: 00000001bee4f000 CR4: 0000000000f50ef0
> [ 6506.666055] [T3176177] PKRU: 55555554
> [ 6506.666056] [T3176177] Call Trace:
> [ 6506.666058] [T3176177]  <TASK>
> [ 6506.666059] [T3176177]  mas_wr_node_store+0x9a/0x3f0
> [ 6506.666063] [T3176177]  ? rt_spin_lock+0x38/0x110
> [ 6506.666065] [T3176177]  ? rt_mutex_slowunlock+0x74/0x290
> [ 6506.666066] [T3176177]  ? __pcs_replace_empty_main+0x2cf/0x410
> [ 6506.666070] [T3176177]  ? kmem_cache_alloc_noprof+0xd4/0x330
> [ 6506.666072] [T3176177]  mas_store_prealloc+0x19d/0x3d0
> [ 6506.666074] [T3176177]  __mmap_region+0x928/0xf80
> [ 6506.666082] [T3176177]  do_mmap+0x478/0x660
> [ 6506.666084] [T3176177]  vm_mmap_pgoff+0x104/0x190
> [ 6506.666087] [T3176177]  elf_load+0xa3/0x230
> [ 6506.666089] [T3176177]  load_elf_binary+0xb80/0x1880
> [ 6506.666091] [T3176177]  ? __kernel_read+0x1a1/0x2a0
> [ 6506.666093] [T3176177]  ? rt_read_lock+0x40/0x130
> [ 6506.666094] [T3176177]  bprm_execve+0x27c/0x4a0
> [ 6506.666096] [T3176177]  do_execveat_common.isra.0+0x157/0x170
> [ 6506.666098] [T3176177]  __x64_sys_execve+0x38/0x50
> [ 6506.666099] [T3176177]  do_syscall_64+0x11b/0x8c0
> [ 6506.666101] [T3176177]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
> [ 6506.666103] [T3176177] RIP: 0033:0x7fc90e432dd7
> [ 6506.666106] [T3176177] Code: Unable to access opcode bytes at 0x7fc90e432dad.
> [ 6506.666107] [T3176177] RSP: 002b:00007fc90e772e68 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
> [ 6506.666108] [T3176177] RAX: ffffffffffffffda RBX: 00007ffec5e8ad00 RCX: 00007fc90e432dd7
> [ 6506.666109] [T3176177] RDX: 000055966c9f03c0 RSI: 00007ffec5e8ab30 RDI: 00007fc90e4fbea4
> [ 6506.666109] [T3176177] RBP: 00007fc90e772ff0 R08: 0000000000000000 R09: 0000000000000000
> [ 6506.666110] [T3176177] R10: 0000000000000008 R11: 0000000000000202 R12: 00007ffec5e8a8b0
> [ 6506.666111] [T3176177] R13: 0000000000000040 R14: 0000000000000001 R15: 00007fc90e772f20
> [ 6506.666112] [T3176177]  </TASK>
> [ 6506.666112] [T3176177] Modules linked in: ccm rfcomm bnep snd_seq_dummy snd_hrtimer snd_seq nls_ascii nls_cp437 vfat fat btusb btrtl btintel btbcm btmtk bluetooth snd_usb_audio ecdh_generic ecc mt7925e mt7925_common snd_usbmidi_lib mt792x_lib snd_ump mt76_connac_lib snd_rawmidi snd_hda_codec_atihdmi joydev intel_rapl_msr snd_hda_codec_hdmi snd_seq_device mt76 mac80211 snd_hda_intel snd_hda_codec intel_rapl_common rapl wmi_bmof pcspkr snd_hda_core snd_intel_dspcfg snd_hwdep snd_pcm libarc4 snd_timer snd soundcore cfg80211 spd5118 regmap_i2c ccp rfkill k10temp evdev nct6775 nct6775_core hwmon_vid efi_pstore configfs efivarfs autofs4 ext4 mbcache jbd2 hid_generic usbhid hid amdgpu drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sched amdxcp drm_display_helper xhci_pci xhci_hcd drm_kms_helper ahci libahci drm libata nvme usbcore nvme_core scsi_mod igc i2c_piix4 nvme_keyring cec i2c_smbus nvme_auth usb_comm
 on scsi_common video crc16 hkdf wmi gpio_amdpt
> [ 6506.666150] [T3176177]  gpio_generic

[..]

> [ 6506.745873] [T3176177] ------------[ cut here ]------------
> [ 6506.745874] [T3176177] rtmutex deadlock detected
> [ 6506.745874] [T3176177] WARNING: kernel/locking/rtmutex.c:1674 at __rt_mutex_slowlock_locked.constprop.0+0x835/0x9b0, CPU#12: sh/3176177
> [ 6506.745878] [T3176177] Modules linked in: ccm rfcomm bnep snd_seq_dummy snd_hrtimer snd_seq nls_ascii nls_cp437 vfat fat btusb btrtl btintel btbcm btmtk bluetooth snd_usb_audio ecdh_generic ecc mt7925e mt7925_common snd_usbmidi_lib mt792x_lib snd_ump mt76_connac_lib snd_rawmidi snd_hda_codec_atihdmi joydev intel_rapl_msr snd_hda_codec_hdmi snd_seq_device mt76 mac80211 snd_hda_intel snd_hda_codec intel_rapl_common rapl wmi_bmof pcspkr snd_hda_core snd_intel_dspcfg snd_hwdep snd_pcm libarc4 snd_timer snd soundcore cfg80211 spd5118 regmap_i2c ccp rfkill k10temp evdev nct6775 nct6775_core hwmon_vid efi_pstore configfs efivarfs autofs4 ext4 mbcache jbd2 hid_generic usbhid hid amdgpu drm_client_lib i2c_algo_bit drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_panel_backlight_quirks gpu_sched amdxcp drm_display_helper xhci_pci xhci_hcd drm_kms_helper ahci libahci drm libata nvme usbcore nvme_core scsi_mod igc i2c_piix4 nvme_keyring cec i2c_smbus nvme_auth usb_comm
 on scsi_common video crc16 hkdf wmi gpio_amdpt
> [ 6506.745900] [T3176177]  gpio_generic
> [ 6506.745902] [T3176177] CPU: 12 UID: 1000 PID: 3176177 Comm: sh Tainted: G      D             7.0.0-rc2-next-20260303-master #367 PREEMPT_RT 
> [ 6506.745904] [T3176177] Tainted: [D]=DIE

So, the KILL signal likely broke it out of the blocked lock, and I believe
the code treated it as a deadlock:

rt_mutex_slowlock_block() has:

		if (signal_pending_state(state, current)) {
			ret = -EINTR;
			break;
		}

Which would return on SIG_KILL even if in the TASK_UNINTERRUPTABLE state.
Then the code after that has:

	if (likely(!ret)) {
		/* acquired the lock */
		if (build_ww_mutex() && ww_ctx) {
			if (!ww_ctx->is_wait_die)
				__ww_mutex_check_waiters(rtm, ww_ctx, wake_q);
			ww_mutex_lock_acquired(ww, ww_ctx);
		}
		lockevent_inc(rtmutex_slow_acq2);
	} else {
		__set_current_state(TASK_RUNNING);
		remove_waiter(lock, waiter);
		rt_mutex_handle_deadlock(ret, chwalk, lock, waiter);
		lockevent_inc(rtmutex_deadlock);
	}

ret is set to -EINTR so it would enter the else block. And then the
rt_mutex_handle_deadlock() prints that a deadlock was detected.

Thus, I don't think this really has anything to do with rtmutex but has to
do with whatever caused that initial general protection fault.

-- Steve


> [ 6506.745905] [T3176177] Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI, BIOS 1627 02/05/2026
> [ 6506.745906] [T3176177] RIP: 0010:__rt_mutex_slowlock_locked.constprop.0+0x835/0x9b0
> [ 6506.745907] [T3176177] Code: 00 48 89 ef e8 fc 67 87 00 c7 44 24 14 fc ff ff ff 41 83 ff dd 0f 85 87 fd ff ff 48 89 ef e8 b2 66 87 00 48 8d 3d 2b 58 f2 00 <67> 48 0f b9 3a bd 01 00 00 00 89 e8 87 43 18 e8 e7 6a fd ff eb f4
> [ 6506.745908] [T3176177] RSP: 0018:ffffb18ba9963d18 EFLAGS: 00010286
> [ 6506.745910] [T3176177] RAX: 0000000000000000 RBX: ffff926654c10000 RCX: ffff926654c10001
> [ 6506.745910] [T3176177] RDX: 0000000000000001 RSI: ffff926654c10000 RDI: ffffffffa9e36620
> [ 6506.745911] [T3176177] RBP: ffff9267bad04bb8 R08: 0000000000000000 R09: ffff92737dcf6f90
> [ 6506.745911] [T3176177] R10: ffff92737dd26fe8 R11: 0000000000000003 R12: ffffb18ba9963d40
> [ 6506.745912] [T3176177] R13: ffff926654c10001 R14: ffff926654c10c40 R15: 00000000ffffffdd
> [ 6506.745913] [T3176177] FS:  0000000000000000(0000) GS:ffff9273933e1000(0000) knlGS:0000000000000000
> [ 6506.745913] [T3176177] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6506.745914] [T3176177] CR2: 00007fc75f94f0f0 CR3: 00000001bee4f000 CR4: 0000000000f50ef0
> [ 6506.745915] [T3176177] PKRU: 55555554
> [ 6506.745915] [T3176177] Call Trace:
> [ 6506.745917] [T3176177]  <TASK>
> [ 6506.745919] [T3176177]  ? load_elf_binary+0xb80/0x1880
> [ 6506.745922] [T3176177]  ? __kernel_read+0x1a1/0x2a0
> [ 6506.745924] [T3176177]  __rwbase_read_lock+0x4a/0xd0
> [ 6506.745927] [T3176177]  acct_collect+0x157/0x1c0
> [ 6506.745931] [T3176177]  do_exit+0x1c2/0xa30
> [ 6506.745933] [T3176177]  make_task_dead+0x94/0xa0
> [ 6506.745934] [T3176177]  rewind_stack_and_make_dead+0x16/0x20
> [ 6506.745937] [T3176177] RIP: 0033:0x7fc90e432dd7
> [ 6506.745941] [T3176177] Code: Unable to access opcode bytes at 0x7fc90e432dad.
> [ 6506.745942] [T3176177] RSP: 002b:00007fc90e772e68 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
> [ 6506.745943] [T3176177] RAX: ffffffffffffffda RBX: 00007ffec5e8ad00 RCX: 00007fc90e432dd7
> [ 6506.745944] [T3176177] RDX: 000055966c9f03c0 RSI: 00007ffec5e8ab30 RDI: 00007fc90e4fbea4
> [ 6506.745944] [T3176177] RBP: 00007fc90e772ff0 R08: 0000000000000000 R09: 0000000000000000
> [ 6506.745945] [T3176177] R10: 0000000000000008 R11: 0000000000000202 R12: 00007ffec5e8a8b0
> [ 6506.745945] [T3176177] R13: 0000000000000040 R14: 0000000000000001 R15: 00007fc90e772f20
> [ 6506.745947] [T3176177]  </TASK>
> [ 6506.745948] [T3176177] ---[ end trace 0000000000000000 ]---
