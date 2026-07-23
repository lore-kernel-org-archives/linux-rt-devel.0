Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B724479892
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Jul 2026 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810639; cv=none; b=oJDQyemTWUBdOnqrh8wlLGP6DevJft0v8uax6CP2Y2sFth05zi3Fo04OmbclrUomPP7I90vioa8x0tyCeY6S1znGTP5n2PxNAibYp7Q6/xbjvYHcZbHt96Isf+oZEvoACNTQCYcNGAiD8AP0Bn2aM2O2z1InmbbzotV5YJ4x8L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810639; c=relaxed/simple;
	bh=FgWuFDxFKMmqWhaaY8VTcCIOt1T5x0zQbg7GAwFRMOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5nvxwWu7xYFeLN7R1MgzR8MqxplMinO9OaooySvbuN7VRgR9RaM8HJU7ck8n5H4VzK4tsN6pfQx2ygFXhj8+ROSVmTkc8i0hGQEpwUy4QQxByFlhN5E7V0+6eI20QVMQ21shR3WMliJiRDoYJWMI+TsS5g2YDLXYgQEaJ9s0So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=kv/h4MQr; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="kv/h4MQr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784810634; x=1785415434; i=spasswolf@web.de;
	bh=n3moBTlrGcmgNYDV5M99R8jPQ+/+zOuJPJWS4sQm2b8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kv/h4MQrq+ZfgnCXfGph/rJP4Ei6HIm+0dS115qFDn6Lokb/bidiVA53U3WAktjg
	 eYLzNWfXg4HL17lj4c9nNyRskUXKe6cTJJXri9oqSgEvKgOPlMMTTrWRqjavIPhaQ
	 g6r9nMLVQRmu5bHfvDrKcOV7FleWagaSk9eQkr0vP3l9ge/A4Ego/ls7XrgaEYQ5N
	 iOc+zC5ewMJibG3ed/4IWUOV6v+EvDXUmM7E0Ls+p4cwuUvhWGN1WBcnK6hp1QojD
	 XIm96/E8vkvHALQK0j9ADY3LQPQsRr147bklZN2MFfqq+OQ+Q+omi4E04jbQgDxUo
	 LS1/L4guSYA7JV4W9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1u6n-1wyODz2KuP-00wrdd; Thu, 23
 Jul 2026 14:43:54 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org,
	Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-next@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [Re] kernel panic during shutdown in v7.2-rc4 and next-20260722 with PREEMPT_RT
Date: Thu, 23 Jul 2026 14:43:51 +0200
Message-ID: <20260723124353.13040-1-spasswolf@web.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: :	<20260723123449.6494-1-spasswolf@web.de>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ecEkC2SUHqEiKd1YPvpfSmt2mvCpIxd92y9z3ojr2NkvIcgvOxO
 aDY7oGTFsPAmMbdbyaP3sZ0w5whK7FrgHar+gzXqlTWyx/HI71J0hvFhZAbbJUSjNt5lf83
 Pz7Bj2qs+PUZyO3yL/ml9GHX3zmrGjny5jn1zDXa11ZG11YhYHvEyTBI5wP7tdu3c5dP/V7
 NZhRjt8/mmZKh9qqvsduA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UVtq6w4pXCU=;PngpfM34KBkmvMarsWL4z+HGPfQ
 mg9z0GheKsC5A2d2xGD/4WVsCKkVZ4//RJ764JZPQWdOyTEEpBkcnisb2rC/h2sNUs84b8XZ/
 25hwWt4vYumSLt701X/gkjfS9KoK0/DhieOZreKnIN1QiWioE2jzW+L4izADVE7vEd9q+y6uc
 YmjKmcyrVwWzDfNQVYguUTRxwR5OythM22ahIaC2O5U1QhpY3hWgcSkTBdM07EiVULGFkKPc8
 A1cqNCnbiClFeWmOVizRn7HwWRVOOlAJhiSsjH77RB4reo1Mnb6eCDtp+qiycV7zMrLbJSWHP
 y81JSgH6hO2ms5nzmZ3RKgMWQCXYz9ygpLkYIhRsIULLBDJa6LWs503KyWFAxarHk6PcS+sYx
 0TBtNLG+7fHDKdU+vreus62NOed0wzsToQwS95mDRg0hd/YxPZdsSzfJRuCDIZiLJyiLLVanQ
 OKA14lIm0rvlgdmDNpB9OpOIZ/4pWN52JN3LaY8pU7/28Rjd/R5qvwsZ9MAkWFEgZDrUv/zUZ
 R8ONevpmdp5lbnjbM7/m3uCylv5KX+6MufRjatKKv2LDDc+yBMVxyEzA6yBT9kdf6ruealRB4
 OCJf19srTDr+ph6JBP0nApfW73hzyyacKSKAwydi7BrRuyDzNuxsurS2SllNTG94SSPxvNnYF
 YctyJEFrIQMgAKtgbLnrOnnG/7QslVHtoSWJ9Mu9UCLhRYWahhe9a8OdabqwISP817+auPl32
 Zk6kQMmBy5wEP+jVeyivXXXqmN2/J15N6QSdph5daQYpuz1Ei7z2/Q2VndpzamjQ1wGZyo3fz
 jX3VcAnSnMW8F3h8Ge1+1220MtBlIXNSdRXVcak4KSlg2J6xIwrsv/Geccz/LtdMOlrC8cQvd
 whTSNYBc3xgq335ii9YfXg9/P0tWOJgwUl7LkP7AldxrU9GE1+fbw9YSWZm7x7LoqmCL40tzj
 PmlR0gyDiLpH6go/gr3dd9rOBAlXhL0xBriuKOdMQOpfOJDkBSVgaSdu6k6qp35HT/VfZDF00
 rDCMzWgnz0ErezdyGJq7T+o8HyX2d0sGWwDDReSOYNnYmVivaLI158AHRKvzhNjVNz+TyDP5j
 r4I4OHp43MtkEfzN9aWN832TjoVY2Cs/tZai9Z5FO1DCbYvh3ZjjBssLh8YA61zHoFLAoKppp
 L11tWrDzeQt+PyIKXZ8k09Ldk9rRoshvQ6TczVhj95y4ZArI6PsTwnkd9Hpd58EoQw1lrEXZb
 WkGC68Z0Ffn6K/O1FoV1vD3JwmvVw0UhRkhtTI9q+ZrbRHDYDmVd/tBX/aCtl1PPGBEEham8v
 SQRHej8THM22OBCLYJqUHY3LMe2DHWUXzMD+J6BPDtjj3YN85rXOkn0R0rimo8SBL1qTabBWU
 Z4DoQGH56NB66mTSHHOpBubRBBPcF9ZyWLwJPCB8XRUnUZas8MB6bTCUXVDTmv4EOj0EExfPz
 pTCBlPBzQ8M6bgfNoths+8SzyljqvLlQNTovoh2jZ8Up/C34tI/w41k96WwL4flWqiSgDtuui
 BVpWuopXxbv7CmE0c/Kd8nwXRrco5D1an6C1KPJu4bMaq6/Ud7Q8dJv8rgt4WjBOfuEDccQpj
 bqxb6D3V0KX6hblc+Qk6cFp0fBSqpMPayetVwO3661AqjPm6/TkwkfbuuIrQ86fEi7QqzFURt
 8WhkrB+VKgz4pnZ9EoXCRaN/yi6pxOAUa591O8qjsnJzZ4l+39ZZaEJ5ngZ/qyN30oVwFio6p
 NOvXU0shxCDmNZZqW7i0ROJZoSXWo9hV04e5nQF+3ottNioInsgzZLvmmBEwpRydOfIp/RI+l
 JWZ557tRJydsfaGzOBAX9S9KGjmsOJMtGBqerpbrDhpr6glLaeMHmtNKdK9XfJD50H/JIyuxy
 SBExrQPy50be7BAbeHTgH2Y7tFc2+bddnyED7b4zMdwuww7QUwbO/OAU1A9XrfzjosWUWFGOx
 GxckmAnAVLOEmkxyfoFXJVbFHhL5ZX2qHQBXx4bhQG6NyHPVrPrUj41gaguiuwPBdU2ZqsNIZ
 xPUmaECRCihVpWOUcJ3xsgSuWvWWW7eEZMmXbf6BFsSUO+lSRGymaKYAGlaIq9ahF8vIfC6OI
 PiE+tgULDlNsTGVfXyc7hXXh+qyK2rGJToEHmmuNqVVMHTkPKNkMdzxsUfde0CpVS++E3tXJ6
 cE3XmWr7jGSwuNYRbFqMZDio6mRta2GvWkSrejUUIvnl4gcAPjKHCqGfGl5HyvmRnrC/vPGpI
 EoM9YPwbWJ6B7+TBJXr1OhSK9DTIVF5qt1vRdQxP8eyhpGF4gkrTvhZXHDusURCl9N814DdB8
 /J8CQbyZ0079fCHtSDB8LyvtEvvAquFntkJxvbTlOutMJ4y4GM+n9ZMCYHd8ip1csilFVpuyG
 isr7bRiPUnZDGqKHfjUly6Gabtr6SxUzzA7VEyYBOA+YToEo82DQGpaKWMpCNjiDC+JkRTWS3
 5hSooFhC0Gkm2CjLKkX0hGqpeSB8K/Gl6vx0SR0IvWAYOR643+/rKy/q1XpzkXAv3GRmhLQlR
 3agr+fxXdLhJAVsRVXgkBKqTtb+0/EKJBPLE5KqxnrPFpDF85CNdsRaghK5uRbGXuNlgAfQFJ
 ISjYczUChigX5aL29gDVQ4WnPZVcqC86c795en4oAr+m4MX2S3CnrNycxNLBMUU+n/ZO+L43I
 pmnIHy1XXz1ykUmSiRf6uKrsqqnEhwKxIbID7TOcivjJLMtp4q1H3ZS5WFnCV4dOzkTSjdM8h
 61gT/7mHuREkzx97Zn5hP0VmEH6a52GQpK+RVb5C/uZDVe1PH95tvDg1ziwd8U+Q7/odUfhbK
 S0ZL9X2TRLJ/u0+SHAhsVVZKnU8Gf+qTodz1RIm460WmPx+opZyps9zO4nYuwC53KBmuxFFWo
 j0BdyORO+8tC+8ptqYVuhAl71lONTe2KOJz14Inhrf8SVz8tK+A6xx0CHibkFlMsUBQZWoQlU
 KzchorZk6RVmF8X+LAPeyUtWqvHU0VpdqQD2OyZerPMzy7OLlpJlCZMkfPs0VU5VY5E+jCApX
 UMiYckt9lY0LAEyAowo9QOhMzzwZ0SGCtc7Gva2CCwd9jUNverAQEMM2JHh5AHSjDCKkFK7Ox
 kKODGoN3r9pHo3S00NeiSqFPz8TqLaB2wYyckne6P2e7AdSb3FKdLLVLaGME2WEIcUXHgFtDt
 IduvPvE/L1oexFBgrVrheYS6WIiL0v6l21diOQuF7iHsRI2Rv7eMbkGfhBY0etYSC2xJ5bC+3
 45PPsopvgYlwgMBOVbZv8uQB71xtooNh9z8y4nSnUeW2c0KHIIJbDyZv2QyMQNccYcWTogEU4
 sZ43okn0AaG8vRgDClO1iVor4zpLIDDHUyM53jTVGXxYFQ7u7XREptQ5vD+wA2q88TXCO30Sj
 jwOETfk7XB9twVR0QsVg3/ZD4ZiGvuIyLg7+1Ku/YZ7zO6bGLy59GPoI+tecHRtcqEz0d10iY
 Td7/dSq2oqWH9C/cQoir01PSK8e7/mfrx4GMqoNVwo1WLkKiaxGd1VSx3z9pT3BlXeAbzTrN9
 Gi8umicmUJjk44aS3x37yWrAG0eRPMimwlk85smA11XluTuCostDGTpCmLZJFbMoucntwzgBE
 voqN2U0OvR7Ubz3T8x5pU+7q/uE5oxjGHpsU48mHapweTisvC6fC50ibGcdh27bMtDiCHoVih
 BHEiZkF3ZaE3vOx2j2Mh8szzf1KZUw5/h2sIEgCSnBJZ4VUBVb2ujylBOrwzqJMNAaWEqUQEV
 Erg+JP029U40d8jPAisgsAwQEV8gmQcwi8adulTNdtoaBzsQiNw+NrBZZMZ8Q1nASHkqFLH1k
 0hjwmQq/i7x/Wv7RJjhseflZ+jI20fH2cmUyrYodU65nfsrWlPP1L9Hswt4vVRJoagGCe1/83
 +XFvAWm9CcK+hnb/mqivqjvOi4ht6VEDMAsU39DN99mb/aYWUYW4KusDZ35gCkRxvM0qLngCA
 fd26ZgKL6xXmgAaDpM2qVX33BpTBHBrPRB/68osUKcujpMepBNjn/S2eeVgK19wvrEAS/Ddh+
 eEdbH0Xbt63J5r4f7iD50e/+8/oWk+AFidcJRB8XwRZ5i3dCgrKIvRb4QFiaNl40vEX6lyvdK
 2eOKOvKQvAEQpPf3nUp3QERMqczprtMPVgCPtUyqJP//4QiQ8ArFjSsYADLjxSkqXufzaNPLn
 wPj0M57ztahKh7kOQhUfN2eZ5tVqfsFNbZjWzNUlL8UZO2qCriGXIo6f2bmkbYMQVwz5HiiQy
 +Ype1Ci6ocY5/cPSQeB+x5xiNQNOOSSqCvEIw5XoRw/35EmIGCvQAKulo0+UWzcmwFlppM7a5
 K49ekDEtnEvT7S64BfUgsoIS7xtgdR2pEuger38F1PLSW7oP6Q7H77szeD6ikdGov/ELiBfVx
 KErv4g8yHjedxUjto9/RaawCis7t2InbGnJhgI2DbEkt6jCHaVB4lbJmJpyG7634jyauPLmcI
 2WDaCQX4DkuMI+eyiOfaOM6xHe4BLEjkqS1ph3nq/t29Vn7HRwZNK27psW2itEO3HOdaABerc
 +trKgPpp7NzYuu5r6f2ZoIC8IOLVMMTgVt5mIGKOF2hur9y4N4ElvknqU0dtcTjgneFZhvmL6
 aI381Lo0Bh5Dy92Z+bIJ452m9WM3OLAA8lbnoZgd3CqxWB66CWlaNa8mUXCU8Lv1D8Nz0g2k0
 pS3rru/YwFk0oEXI4GK2nwRKcog37DSMakiNVN4iy4PglqKx5/N5qQ6G9l/cl42TxkCsNY7v0
 U4r06uq0GbtvlDaT3spUzibc0TDziT5lDprkcgjbV9aypTH9pdRheg07H46HE/kgo1crF7OWf
 PPz5XBlWHSbceFq9n0KM1JZR7gGbf2w+F15EVhZa8dZTzkA+GMIgD01G0fio+K8q9TSic5ISr
 egUbIQUAB8bUdhNnMEKOFajB/Jp2j8OSOJypZSv9uVJ+QWNleCq+tvR8QYh4xQNYE1Wt6ZUEe
 Q4z9JiwKjEimd3dIJP61nr/TKz7LLzVQhBCpYicpfyhhp1OmmABSsBbmFDZCIM8A+z7Yagewy
 IQ4tRMczNA+528Vb3vPM0D7Zz91SWUCDzlxdfnPiTp10zSlHii9DWaL9n1BJWDt82iT4JGA8x
 8NsvLCsokY4B9c7+AYK9iRpV/qkuGpLNQtl5ubJG12u+YVkTtTDNFfrj9/aJCD3FdQ4c4qkCV
 AAr5VVx9p7vRCu9rN1GZ9Tv+TbYzRvq8el4s1Nst9CremsZNChpuqUn9bRvBpTPhs5LDIG4Nh
 UG04aA2w4Jx2x2iM/gDZXH4cIPJH72AAmpWTz1e9ENs8p+6/PaiLFoEdFNZs5Icdv1Clpt6z3
 j1Wu9sl12GCZp+y2etjaF0CP3LQGIzOm7lnSqdeFdmJR9b79Zr1s26g7Jlhf4Cn8hCFuc6BmY
 gi3Sq2zab+D6diMRRB4W4I3IzTv+YSusqnwn/U/2xmIR/4DAUwsLOQZa68EbxDaucvjWdR1uo
 2KpZAf98Dkdxg7Q2i5z4NDTr7u9oLR2b4ZOjOc6rhtJceXUnLdblj3vh6R2kXFa/Seh1pCUrw
 emvNyDh/Fdd6PCLCNRe2N1DLoFuRoPJFJqCgmY2c6dZhOfxgnBugd76Ph311Zeke2UzBvxCkE
 HNqh/qqZ+9mzqLyrIo5cshdppVo04KrjWzO8eA2xH27y9kLdWTZQF3ys3CqMR/a5K+BDzdSMq
 jIV560UEwaE0KgQ5qPo4ZyEWAcN+D+K3HikRmYIBPj9SK8H08P/q81PJcwE3aAC6TbfoXqSWV
 23DhVRs38NVj8M+cIm8SPfzcF0w4wjKqz53qSfBT3/w==

I was able to gather an error message from a failed shutdwon in v7.2-rc4:

T1475;BUG: scheduling while atomic: Xorg/1475/0x00000003
T1475,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e s=
nd_usbmidi_lib mt7925_common snd_ump mt792x_lib snd_rawmidi intel_rapl_msr=
 snd_seq_device mt76_connac_lib iosf_mbi intel_rapl_common mt76 snd_hda_co=
dec_atihdmi rapl snd_hda_codec_hdmi mac80211 snd_hda_intel pcspkr wmi_bmof=
 snd_hda_codec snd_hda_core snd_intel_dspcfg snd_hwdep snd_pcm libarc4 spd=
5118 snd_timer cfg80211 regmap_i2c snd soundcore rfkill aead evdev ccp k10=
temp nct6775 nct6775_core hwmon_vid configfs efi_pstore efivarfs autofs4 e=
xt4 mbcache jbd2 amdgpu hid_generic usbhid drm_client_lib i2c_algo_bit hid=
 drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_pa=
nel_backlight_quirks gpu_sched amdxcp drm_display_helper ahci libahci xhci=
_pci libata xhci_hcd drm_kms_helper drm scsi_mod igc nvme usbcore cec nvme=
_core scsi_common crc16 video nvme_keyring i2c_piix4 gpio_amdpt usb_common=
 nvme_auth wmi
T1475,ncfrag=3D955/979; i2c_smbus gpio_generic
T1475;CPU: 22 UID: 0 PID: 1475 Comm: Xorg Not tainted 7.2.0-rc4-stable #16=
 PREEMPT_{RT,(full)}=20
T1475;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1475;Call Trace:
T1475; <TASK>
T1475; ? dump_stack_lvl+0x4b/0x70
T1475; ? __schedule_bug.cold+0x3e/0x4a
T1475; ? __schedule+0xf64/0x16f0
T1475; ? pick_task_fair+0x4b/0x6e0
T1475; ? schedule_rtlock+0x15/0x30
T1475; ? rtlock_slowlock_locked+0x30c/0xe50
T1475; ? rt_spin_lock+0xc3/0x120
T1475; ? get_page_from_freelist+0x22e/0x1640
T1475; ? __alloc_frozen_pages_noprof+0x146/0x2b0
T1475; ? ___kmalloc_large_node+0xae/0xd0
T1475; ? __kvmalloc_node_noprof+0x36c/0x580
T1475; ? dc_create_plane_state+0x24/0x80 [amdgpu]
T1475; ? dc_create_plane_state+0x24/0x80 [amdgpu]
T1475; ? dc_state_create_phantom_plane+0x15/0x50 [amdgpu]
T1475; ? dml21_handle_phantom_streams_planes+0x292/0x510 [amdgpu]
T1475; ? dml21_mode_check_and_programming+0x157/0x7e0 [amdgpu]
T1475; ? spl_set_filters_data+0xbc/0xd0 [amdgpu]
T1475; ? spl_calculate_scaler_params+0x39d/0x1c00 [amdgpu]
T1475; ? dc_state_remove_plane+0xaf/0x150 [amdgpu]
T1475; ? dcn401_validate_bandwidth+0xb8/0x1f0 [amdgpu]
T1475; ? update_planes_and_stream_state+0xfc7/0x16a0 [amdgpu]
T1475; ? update_planes_and_stream_prepare_v3+0xb6/0x430 [amdgpu]
T1475; ? dc_update_planes_and_stream+0x87/0x140 [amdgpu]
T1475; ? amdgpu_dm_atomic_commit_tail+0x16c0/0x3800 [amdgpu]
T1475; ? commit_tail+0xad/0x140 [drm_kms_helper]
T1475; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1475; ? drm_atomic_commit+0xac/0xe0 [drm]
T1475; ? __drm_universal_plane_init.cold+0x11/0x11 [drm]
T1475; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1475; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1475; ? rt_spin_lock+0x35/0x120
T1475; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1475; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1475; ? drm_ioctl+0x27f/0x500 [drm]
T1475; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1475; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1475; ? __x64_sys_ioctl+0x92/0xe0
T1475; ? do_syscall_64+0xdd/0x5d0
T1475; ? amdgpu_drm_ioctl+0x65/0x80 [amdgpu]
T1475; ? __x64_sys_ioctl+0xac/0xe0
T1475; ? switch_fpu_return+0x42/0x70
T1475; ? do_syscall_64+0x226/0x5d0
T1475; ? __ext4_journal_stop+0x3a/0xc0 [ext4]
T1475; ? ext4_da_write_end+0x2de/0x340 [ext4]
T1475; ? generic_perform_write+0x131/0x280
T1475; ? up_write+0x29/0x50
T1475; ? psi_group_change+0x112/0x2c0
T1475; ? update_cfs_rq_load_avg+0x1a/0x240
T1475; ? psi_task_switch+0x105/0x280
T1475; ? finish_task_switch.isra.0+0xc2/0x3c0
T1475; ? __schedule+0x374/0x16f0
T1475; ? do_syscall_64+0x572/0x5d0
T1475; ? do_syscall_64+0x572/0x5d0
T1475; ? do_syscall_64+0x572/0x5d0
T1475; ? do_syscall_64+0x94/0x5d0
T1475; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1475; </TASK>
T1475;------------[ cut here ]------------
T1475;WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:12=
6 at dc_fpu_end+0x36/0x40 [amdgpu], CPU#1: Xorg/1475
T1475,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e s=
nd_usbmidi_lib mt7925_common snd_ump mt792x_lib snd_rawmidi intel_rapl_msr=
 snd_seq_device mt76_connac_lib iosf_mbi intel_rapl_common mt76 snd_hda_co=
dec_atihdmi rapl snd_hda_codec_hdmi mac80211 snd_hda_intel pcspkr wmi_bmof=
 snd_hda_codec snd_hda_core snd_intel_dspcfg snd_hwdep snd_pcm libarc4 spd=
5118 snd_timer cfg80211 regmap_i2c snd soundcore rfkill aead evdev ccp k10=
temp nct6775 nct6775_core hwmon_vid configfs efi_pstore efivarfs autofs4 e=
xt4 mbcache jbd2 amdgpu hid_generic usbhid drm_client_lib i2c_algo_bit hid=
 drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_pa=
nel_backlight_quirks gpu_sched amdxcp drm_display_helper ahci libahci xhci=
_pci libata xhci_hcd drm_kms_helper drm scsi_mod igc nvme usbcore cec nvme=
_core scsi_common crc16 video nvme_keyring i2c_piix4 gpio_amdpt usb_common=
 nvme_auth wmi
T1475,ncfrag=3D955/979; i2c_smbus gpio_generic
T1475;CPU: 1 UID: 0 PID: 1475 Comm: Xorg Tainted: G        W           7.2=
.0-rc4-stable #16 PREEMPT_{RT,(full)}=20
T1475;Tainted: [W]=3DWARN
T1475;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1475;RIP: 0010:dc_fpu_end+0x36/0x40 [amdgpu]
T1475;Code: 05 4f df 16 c7 ff c8 74 10 78 1f 65 ff 0d 72 cf 15 c7 74 0c c3=
 cc cc cc cc e8 96 95 12 c6 eb eb e8 ef 09 11 c6 c3 cc cc cc cc <0f> 0b eb=
 dd 66 0f 1f 44 00 00 41 56 41 55 41 54 55 53 48 83 ec 10
T1475;RSP: 0018:ffffb6c2059d7118 EFLAGS: 00010296
T1475;RAX: 00000000ffffffff RBX: ffff9e1a61f00000 RCX: 0000000000000008
T1475;RDX: 0000000000000000 RSI: 0000000000000719 RDI: ffffffffc13b3550
T1475;RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
T1475;R10: ffff9e1a61f00000 R11: 0000000000000002 R12: ffff9e16cc280000
T1475;R13: ffff9e1721c00000 R14: 0000000000000000 R15: 0000000000000001
T1475;FS:  00007fbc7ca7eb80(0000) GS:ffff9e26757b5000(0000) knlGS:00000000=
00000000
T1475;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
T1475;CR2: 00007ff1aa4e5000 CR3: 000000010d0d3000 CR4: 0000000000f50ef0
T1475;PKRU: 55555554
T1475;Call Trace:
T1475; <TASK>
T1475; ? dcn401_validate_bandwidth+0xd1/0x1f0 [amdgpu]
T1475; ? update_planes_and_stream_state+0xfc7/0x16a0 [amdgpu]
T1475; ? update_planes_and_stream_prepare_v3+0xb6/0x430 [amdgpu]
T1475; ? dc_update_planes_and_stream+0x87/0x140 [amdgpu]
T1475; ? amdgpu_dm_atomic_commit_tail+0x16c0/0x3800 [amdgpu]
T1475; ? commit_tail+0xad/0x140 [drm_kms_helper]
T1475; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1475; ? drm_atomic_commit+0xac/0xe0 [drm]
T1475; ? __drm_universal_plane_init.cold+0x11/0x11 [drm]
T1475; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1475; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1475; ? rt_spin_lock+0x35/0x120
T1475; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1475; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1475; ? drm_ioctl+0x27f/0x500 [drm]
T1475; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1475; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1475; ? __x64_sys_ioctl+0x92/0xe0
T1475; ? do_syscall_64+0xdd/0x5d0
T1475; ? amdgpu_drm_ioctl+0x65/0x80 [amdgpu]
T1475; ? __x64_sys_ioctl+0xac/0xe0
T1475; ? switch_fpu_return+0x42/0x70
T1475; ? do_syscall_64+0x226/0x5d0
T1475; ? __ext4_journal_stop+0x3a/0xc0 [ext4]
T1475; ? ext4_da_write_end+0x2de/0x340 [ext4]
T1475; ? generic_perform_write+0x131/0x280
T1475; ? up_write+0x29/0x50
T1475; ? psi_group_change+0x112/0x2c0
T1475; ? update_cfs_rq_load_avg+0x1a/0x240
T1475; ? psi_task_switch+0x105/0x280
T1475; ? finish_task_switch.isra.0+0xc2/0x3c0
T1475; ? __schedule+0x374/0x16f0
T1475; ? do_syscall_64+0x572/0x5d0
T1475; ? do_syscall_64+0x572/0x5d0
T1475; ? do_syscall_64+0x572/0x5d0
T1475; ? do_syscall_64+0x94/0x5d0
T1475; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1475; </TASK>
T1475;---[ end trace 0000000000000000 ]---
T1475;------------[ cut here ]------------
T1475;WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:97=
 at dc_fpu_begin+0x4f/0x60 [amdgpu], CPU#23: Xorg/1475
T1475,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e s=
nd_usbmidi_lib mt7925_common snd_ump mt792x_lib snd_rawmidi intel_rapl_msr=
 snd_seq_device mt76_connac_lib iosf_mbi intel_rapl_common mt76 snd_hda_co=
dec_atihdmi rapl snd_hda_codec_hdmi mac80211 snd_hda_intel pcspkr wmi_bmof=
 snd_hda_codec snd_hda_core snd_intel_dspcfg snd_hwdep snd_pcm libarc4 spd=
5118 snd_timer cfg80211 regmap_i2c snd soundcore rfkill aead evdev ccp k10=
temp nct6775 nct6775_core hwmon_vid configfs efi_pstore efivarfs autofs4 e=
xt4 mbcache jbd2 amdgpu hid_generic usbhid drm_client_lib i2c_algo_bit hid=
 drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_pa=
nel_backlight_quirks gpu_sched amdxcp drm_display_helper ahci libahci xhci=
_pci libata xhci_hcd drm_kms_helper drm scsi_mod igc nvme usbcore cec nvme=
_core scsi_common crc16 video nvme_keyring i2c_piix4 gpio_amdpt usb_common=
 nvme_auth wmi
T1475,ncfrag=3D955/979; i2c_smbus gpio_generic
T1475;CPU: 23 UID: 0 PID: 1475 Comm: Xorg Tainted: G        W           7.=
2.0-rc4-stable #16 PREEMPT_{RT,(full)}=20
T1475;Tainted: [W]=3DWARN
T1475;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1475;RIP: 0010:dc_fpu_begin+0x4f/0x60 [amdgpu]
T1475;Code: d0 75 27 65 ff 05 c1 cf 15 c7 b8 01 00 00 00 65 0f c1 05 84 df=
 16 c7 85 c0 74 05 c3 cc cc cc cc bf 02 00 00 00 e9 51 96 12 c6 <0f> 0b eb=
 d5 66 90 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 d6 b8
T1475;RSP: 0018:ffffb6c2059d7448 EFLAGS: 00010206
T1475;RAX: 0000000000ff0000 RBX: ffff9e1721c00000 RCX: ffff9e1703380000
T1475;RDX: 0000000000ff0000 RSI: 000000000000073d RDI: ffffffffc13b3520
T1475;RBP: 0000000000000001 R08: ffffb6c2059d741c R09: 000000000000000a
T1475;R10: ffffb6c2059d73c0 R11: 0000000000000002 R12: ffff9e16cc280000
T1475;R13: ffff9e16c14f7000 R14: ffff9e1a61f00000 R15: ffff9e1721c00000
T1475;FS:  00007fbc7ca7eb80(0000) GS:ffff9e2675d35000(0000) knlGS:00000000=
00000000
T1475;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
T1475;CR2: 0000557a0c9a9cc8 CR3: 000000010d0d3000 CR4: 0000000000f50ef0
T1475;PKRU: 55555554
T1475;Call Trace:
T1475; <TASK>
T1475; ? dcn401_prepare_mcache_programming+0x2f/0x70 [amdgpu]
T1475; ? commit_planes_for_stream+0x155/0x1900 [amdgpu]
T1475; ? update_planes_and_stream_execute_v3+0x3c/0xd0 [amdgpu]
T1475; ? dc_update_planes_and_stream+0xb6/0x140 [amdgpu]
T1475; ? amdgpu_dm_atomic_commit_tail+0x16c0/0x3800 [amdgpu]
T1475; ? commit_tail+0xad/0x140 [drm_kms_helper]
T1475; ? drm_atomic_helper_commit+0x137/0x180 [drm_kms_helper]
T1475; ? drm_atomic_commit+0xac/0xe0 [drm]
T1475; ? __drm_universal_plane_init.cold+0x11/0x11 [drm]
T1475; ? drm_atomic_helper_set_config+0x6f/0xb0 [drm_kms_helper]
T1475; ? drm_mode_setcrtc+0x443/0x8b0 [drm]
T1475; ? rt_spin_lock+0x35/0x120
T1475; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1475; ? drm_ioctl_kernel+0xa1/0xf0 [drm]
T1475; ? drm_ioctl+0x27f/0x500 [drm]
T1475; ? drm_mode_getcrtc+0x180/0x180 [drm]
T1475; ? amdgpu_drm_ioctl+0x45/0x80 [amdgpu]
T1475; ? __x64_sys_ioctl+0x92/0xe0
T1475; ? do_syscall_64+0xdd/0x5d0
T1475; ? amdgpu_drm_ioctl+0x65/0x80 [amdgpu]
T1475; ? __x64_sys_ioctl+0xac/0xe0
T1475; ? switch_fpu_return+0x42/0x70
T1475; ? do_syscall_64+0x226/0x5d0
T1475; ? __ext4_journal_stop+0x3a/0xc0 [ext4]
T1475; ? ext4_da_write_end+0x2de/0x340 [ext4]
T1475; ? generic_perform_write+0x131/0x280
T1475; ? up_write+0x29/0x50
T1475; ? psi_group_change+0x112/0x2c0
T1475; ? update_cfs_rq_load_avg+0x1a/0x240
T1475; ? psi_task_switch+0x105/0x280
T1475; ? finish_task_switch.isra.0+0xc2/0x3c0
T1475; ? __schedule+0x374/0x16f0
T1475; ? do_syscall_64+0x572/0x5d0
T1475; ? do_syscall_64+0x572/0x5d0
T1475; ? do_syscall_64+0x572/0x5d0
T1475; ? do_syscall_64+0x94/0x5d0
T1475; ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
T1475; </TASK>
T1475;---[ end trace 0000000000000000 ]---
T1475;BUG: scheduling while atomic: Xorg/1475/0x00000000
T1475,ncfrag=3D0/979;Modules linked in: netconsole ccm snd_seq_dummy snd_h=
rtimer snd_seq nls_ascii nls_cp437 vfat fat joydev snd_usb_audio mt7925e s=
nd_usbmidi_lib mt7925_common snd_ump mt792x_lib snd_rawmidi intel_rapl_msr=
 snd_seq_device mt76_connac_lib iosf_mbi intel_rapl_common mt76 snd_hda_co=
dec_atihdmi rapl snd_hda_codec_hdmi mac80211 snd_hda_intel pcspkr wmi_bmof=
 snd_hda_codec snd_hda_core snd_intel_dspcfg snd_hwdep snd_pcm libarc4 spd=
5118 snd_timer cfg80211 regmap_i2c snd soundcore rfkill aead evdev ccp k10=
temp nct6775 nct6775_core hwmon_vid configfs efi_pstore efivarfs autofs4 e=
xt4 mbcache jbd2 amdgpu hid_generic usbhid drm_client_lib i2c_algo_bit hid=
 drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper mfd_core drm_pa=
nel_backlight_quirks gpu_sched amdxcp drm_display_helper ahci libahci xhci=
_pci libata xhci_hcd drm_kms_helper drm scsi_mod igc nvme usbcore cec nvme=
_core scsi_common crc16 video nvme_keyring i2c_piix4 gpio_amdpt usb_common=
 nvme_auth wmi
T1475,ncfrag=3D955/979; i2c_smbus gpio_generic
T1475;CPU: 20 UID: 0 PID: 1475 Comm: Xorg Tainted: G        W           7.=
2.0-rc4-stable #16 PREEMPT_{RT,(full)}=20
T1475;Tainted: [W]=3DWARN
T1475;Hardware name: ASUS System Product Name/ROG STRIX B850-F GAMING WIFI=
, BIOS 1627 02/05/2026
T1475;Call Trace:
T1475; <TASK>
T1475; ? dump_stack_lvl+0x4b/0x70

I'll probably try CONFIG_LOCKDEP=3Dy next.

Bert Karwatzki


