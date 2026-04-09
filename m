Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F222DCBF8
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Apr 2026 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741456; cv=none; b=TqTKACJMVrwrBiyPtXFR6UGYXX+7h541GiH0EOF+SXIKc2CdQdXrsNXhf5jnX7aTOrOvav+gUhK5x9y5ji5tpWOaZwkFAZfMPknuR5Jz1IZco+Ytw9gSctaRPautLEcgVW8vUfD4tqvLpxGa/uTsahX9lSuxgFi3nhUYh63vRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741456; c=relaxed/simple;
	bh=Pt+2JUt5fbXETQ96nttuKWoC5XlpX0e5K8lQc1fcZMY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XtwgAv4dz58l2qf3yJpHi7EPAi/zegy0xcrUcIMBWfsHaiVv5MdKRgU1Vsw+tbUwtTuT0ZAP2o1N769tblRp2tD+A+nlKezIgsn+QXDtYMe+bcQ1IUzhd/Gr/rj6uZyFMB0GRJnqF86uBlGVngubVfDzq3klaV2fcRILkAhslug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=dA5lm5OE; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="dA5lm5OE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1775741452; x=1776346252; i=spasswolf@web.de;
	bh=hXOC497Eg5/wV6WqBIGUnnuft83o6qJTAiZgUhifHG4=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dA5lm5OE0WcGw7m1mB+p4+yhfixQpLdn92Qk8wYEGF1xZ9IZVvidUrDL4dSe5O1H
	 jjfH2IAbtAoO12wpduojZRT5ufLJo4qvpC+RhuhMRP8Ds67xpQtd/IhNl+QnB0Uly
	 xtykQw2AcNYj/sHI5AZKttjx3ZNyPyjtYYW6GfjL+A+CJE1DgrxFIllcLKPTs4C6S
	 feFwOUNoQ3tet0ADamCpAvM3NFoZCv58XF3/sXDSHHkAXCxewSg2f6iWgVo1Ytsio
	 drZ8MsrEaN5MbAhCY2OMuu/tjPN4ULKm+ksu76guWvJedMvy/yFVDtj1jjhU+iuJx
	 KNPgl65SFisueQHDbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnX5T-1vitFR3N5h-00gwft; Thu, 09
 Apr 2026 15:30:52 +0200
Message-ID: <cbd18570adb605fcb699219b4a8662cb301f398c.camel@web.de>
Subject: Re: kernel panic when resuming from hibernate in next-20260406 with
 PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: Dillon Varone <dillon.varone@amd.com>, spasswolf@web.de, Alex Hung	
 <alex.hung@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org
Date: Thu, 09 Apr 2026 15:30:52 +0200
In-Reply-To: <20260409131411.10598-1-spasswolf@web.de>
References: <20260409131411.10598-1-spasswolf@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YVeqYFyMxaI0LWxCV+qojBbRJEgtWbE4gFoY1KqakQlXH8NUkkH
 7jI5i3NzjnPpf9tugGNuCi49lvse9MoCuujouVc/Plos+VDxGnd3Z4mGMN+xy+fNcF+jaBa
 iDP+ub+4iz8wWuWsOl8fJXgACCM9VC9lmuC2hoZnIm9ewvdIB3v+BduWxMQmZSaRttwRrXL
 GjGXmwxNe+aVKWv5ns8Vw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qEDgRkMIgog=;vOf/6iFyWFbaO7R220IYbZKRlVj
 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

Am Donnerstag, dem 09.04.2026 um 15:14 +0200 schrieb Bert Karwatzki:
> I noticed that my debian stable (trixie) system running linux next-20260=
406
> would sometimes hang when resuming from hibernate (I also had two simila=
r errors
> under different circumstances, one just after booting and one when start=
ing the
> game stellaris, but hibernate seems to be the best way to provoke this e=
rror).=20
> There are usually no error messages, but once I got this (incomplete) er=
ror (via drm panic "kmsg"):
>=20
>=20
>=20
> [ 125.266334][ C17] RSP: 002b:00007ffc1fcae230 EFLAGS: 00000246 ORIG_RAX=
: 0000000000000010
> [ 125.266335][ C17] RAX: ffffffffffffffda RBX: 000055845b640060 RCX: 000=
07fb699e8e91b
> [ 125.266335][ C17] RDX: 00007ffc1fcae2d0 RSI: 00000000c05064a7 RDI: 000=
000000000000f
> [ 125.266336][ C17] RBP: 00007ffc1fcae2d0 R08: 0000000000000060 R09: 000=
0000000000000
> [ 125.266336][ C17] R10: 0000000000000003 R11: 0000000000000246 R12: 000=
00000c05064a7
> [ 125.266336][ C17] R13: 000000000000000f R14: 00000000c05064a7 R15: 000=
07ffc1fcae2d0
> [ 125.266337][ C17] &lt;/TASK&gt;
> [ 125.266337][ C17] Modules linked in: ccm snd_usb_audio joydev snd_usbm=
idi_lib snd_ump snd_rawmidi snd_seq_dummy snd_hrtimer snd_seq snd_seq_devi=
ce nls_ascii nls_cp437 vfat fat mt7925e mt7925_common mt792x_lib mt76_conn=
ac_lib mt76 intel_rapl_msr snd_hda_codec_atihdmi mac80211 intel_rapl_commo=
n snd_hda_codec_hdmi iosf_mbi snd_hda_intel rapl snd_hda_codec wmi_bmof sn=
d_hda_core spd5118 regmap_i2c snd_intel_dspcfg snd_hwdep snd_pcm libarc4 s=
nd_timer cfg80211 snd soundcore pcspkr rfkill ccp k10temp evdev nct6775 nc=
t6775_core hwmon_vid configfs efi_pstore efivarfs autofs4 ext4 mbcache jbd=
2 hid_generic usbhid hid amdgpu drm_client_lib i2c_algo_bit drm_buddy drm_=
ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_panel_backlight_q=
uirks gpu_sched amdxcp drm_display_helper xhci_pci xhci_hcd drm_kms_helper=
 ahci libahci drm libata usbcore nvme scsi_mod igc nvme_core cec i2c_piix4=
 scsi_common video usb_common nvme_keyring crc16 i2c_smbus nvme_auth wmi h=
kdf gpio_amdpt gpio_generic
> [ 125.266351][ C17] ---[ end trace 0000000000000000 ]---
> [ 126.356624][ C17] RIP: 0010:__get_vm_area_node+0x140/0x150
> [ 126.356631][ C17] Code: 00 00 ff c5 39 c5 0f 4c e8 b8 1e 00 00 00 39 c=
5 0f 4f e8 c4 e2 d1 f7 ea e9 3e ff ff ff 4c 89 e7 e8 f5 49 01 00 45 31 e4 =
eb b0 &lt;0f&gt; 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 40 d6 =
41 50
> [ 126.356633][ C17] RSP: 0018:ffffb50f075275f8 EFLAGS: 00010206
> [ 126.356635][ C17] RAX: 0000000000ff0000 RBX: 000000000000000c RCX: 000=
0000000000022
> [ 126.356636][ C17] RDX: 0000000000ff0000 RSI: 0000000000000001 RDI: 000=
000000000f720
> [ 126.356637][ C17] RBP: 000000000000000c R08: ffffb50f00000000 R09: fff=
fd50effffffff
> [ 126.356637][ C17] R10: ffffd50effffffff R11: 0000000000000006 R12: fff=
f9090a6000000
> [ 126.356638][ C17] R13: ffff9090a62e9fd0 R14: 000000000000f720 R15: 000=
0000000000dc0
> [ 126.356639][ C17] FS: 00007fb699b0eb40(0000) GS:ffff90a00a848000(0000)=
 knlGS:0000000000000000
> [ 126.356640][ C17] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 126.356640][ C17] CR2: 00007f617c3fa02f CR3: 00000001a0c4e000 CR4: 000=
0000000f50ef0
> [ 126.356641][ C17] PKRU: 55555554
> [ 126.356642][ C17] Kernel panic - not syncing: Fatal exception in inter=
rupt
> [ 126.356811][ C17] Kernel Offset: 0x30a00000 from 0xffffffff81000000 (r=
elocation range: 0xffffffff80000000-0xffffffffbfffffff)
>=20
>=20
> Any Ideas?
>=20
> Bert Karwatzki
>=20

In just checked the error message with faddr2line and got this:

$ scripts/faddr2line mm/vmalloc.o __get_vm_area_node+0x140/0x150
__get_vm_area_node+0x140/0x150:
__get_vm_area_node at /mnt/data/linux-forest/linux-next/mm/vmalloc.c:3212 =
(discriminator 1)

line 3213 in __get_vm_area_node is this:

	BUG_ON(in_interrupt());

So the problem is using __get_vm_area_node() (presumably via kzalloc() as =
this is the only vm function
in the offending poatch) from interrupt context.

Bert Karwatzki=20


