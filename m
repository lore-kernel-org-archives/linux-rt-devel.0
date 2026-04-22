Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8153A5E62
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Apr 2026 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776882604; cv=pass; b=dIIZ/+X0aDgkGR2HUbfsTnqE73TnvAEKVChQqLzIx+vN51mD9bc7inyhjfGQomAw+4mStpMpEGX4Xh4sKK06sycVVYSx6K1Oca3GQmLJxV8p5sMKfLWvdzoIIMf3ebkjnrvg/Q11WYBEzezGpWdBcBXI6Z9+foHQ49Xe0l/MybE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776882604; c=relaxed/simple;
	bh=cDLiIbpQ4C0rfS9ZCxoI4yN7JKXdGP763zZYXX2KLq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTEPwbbQ4fv8xFB2ZC4JlOvTJo3Ormxc9k3YG7OhiebgMFJm/8x9HflEAQEfAu+6cNeE538EOJczlO4cOt9/u89XuafuOdf3nGSUM2WTAxvBgjGbxk8KXBquIPeuq99PqTjmJT7SVSt9v0ECpGy208TwsURiXS64ZRkIm+56TZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLoq/MIr; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLoq/MIr"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f8bf96b46so2912959b3a.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 22 Apr 2026 11:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776882602; cv=none;
        d=google.com; s=arc-20240605;
        b=SjS/l6VZZmBW8xjl+3AqbddwyGWaOS/X9AFF5WR2kG0/JiSmPdmewMz57wYiyfr5eo
         1fFQ93O9PJ/2t1bdTqe00NguhmGJ2gghiFsMLI3Z4CdK/GRzigqhnvIakC6XzPAjSp7d
         Mj6DBMEJkxZ8jgM8PMXD+LIa8ZHXND3zS/4qMleRyX9mMfvfvMn2uDx6Hw9S+kftciG5
         qFdFk9BtMdfwWwroFc/WXXsiJcoHi3P9xt14pIMlTmKr9o3z2cjWb7knJ1GW5emfQBRE
         +FNZqSYZBXHBSBMUAS46DHY7g3HsBn2GtR+M0kj3tDCFVQLuoSXGC80/19nfDXC5i+49
         hawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u4/X37XCFva5OVnePm1MhKl37TKCmccKP8OvCY5aZo8=;
        fh=4rHtoJt3SFPSW5F4aTPyr9G2Tdf8OwVZi05V41tcfnc=;
        b=ZF+iPHc4G8VwwlwY5uMAReuNj9LFWIqz+d2M315rx88lLTGV+t2I67iU/vSH1gogE2
         zyBMV26Oc3pfpvKqU5qnCqfuhzsz6xC7/XGM65vd1qBI8Z7GGPe8PlftwOymZq8rifUw
         IX7lXXR9twHsM+hvDqwzBo/7ef46I3mjevowh1n3VECNuBaYVWFA+fWY8XQM5kostLWz
         BDVJ8Qi3lYFvVI8zo9/017Kwn6IZd6RpU4Tqx4Oo+I9nQ2dnfCpDlvGwozamijKpoKaO
         99sZwAhBpKd/ZWrEqbr+C0wUT7zeG8tGgaHoOhK466Q8R8uIy0kpUeaLKA2sYlEnvGdV
         5LuQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776882602; x=1777487402; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4/X37XCFva5OVnePm1MhKl37TKCmccKP8OvCY5aZo8=;
        b=iLoq/MIrpGyXT1TtY/OUwngNWcViZLHcqLFidU111UOpI6rbc2q9O1dR5D4B/We4SA
         qa1KCZodXCk88rIc4yDkUkMn+sQzgxmmtzEoSEBenN+vEMDMZA3XImgfUzhVLWbr5WdZ
         9GFqgez5NnaHWZJPJvoM667yesQQRNBSlnYNcpTLdvU5wZ6cLSqjEIf+8EsYyhNWJS5m
         Bgypav9uGcrP2OEXiJ1UDrj/+Upxy2J0MSDo9QdKzqnoTBsF4fhBU+n2BVrlQNt4ECYN
         cY0He30aUPrbUBTqEDN+CGC5ADbb5gPESDT3kMpI0icLAQ/ndPlRELCnEfRyxc715Sak
         r78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776882602; x=1777487402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u4/X37XCFva5OVnePm1MhKl37TKCmccKP8OvCY5aZo8=;
        b=T/p5XeERyAkkUwWJNdH8ObGPmhR1+zkjh0WLmfy3E4DBhBZrlVvaLxD0QxvginMy5E
         AHfs58GYD21Fz1lFIz1mI9eu9+ZoVNPTh4yZdnInPccVmV0GAyskT20g599AhyeInYDR
         qSsjk4qYWd7PM+sI6EJV3gK74wed7pZ0P/oWxZfODNEs6RECYBoHER6ttB6E/viIKsyM
         ISzrgz+6Uwz0ezQhL8URn4dtjknkT222zSBuMGwqg+fMHK0nLBQSuoIb74hMbIt6K6Ln
         e3JyPcYD6eE+gkl7LRFgewm6Bi5zZZKVDSvTZqXj0uJSojCHnEnZKEXkG3tQp3IPXYLy
         YuNw==
X-Forwarded-Encrypted: i=1; AFNElJ8Qq9zpxETZ6LVBJsRsav8CLBC4du63O7wUHFWbUY/yaZH7nF8nw7Uw8mjbFqDr6y7ImxE2GdWhvzQL8KLMDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzjx8xkreeaR3Z+SlcHEwpW+3dccH0hwgNMVd6W7nCzjTBg7wXh
	6Qs30fAQoj9/eCbwXkwbP8xGCvu1AO1rDlEIEeDVqvuyWc4lcNyvwgbsoA7ZaKK618H1p6soq23
	FO8a8N3Se62Or9Fp3WaxANpzFvHceK2g=
X-Gm-Gg: AeBDieuFxV3IxxaLSY8ctwCY5eAXDhqq6fQseVdcVDpAmexKm3PIikENmna202jeujB
	9U896dT2u8EsUKYctBdNGNGC11bn4kh/DgDGEvYzyO42FRz+vGV7h96Of8MnAWFus5PxSFR1ofL
	OlAKX2bEHjQd0ioIV8tk6cefcmjcUDInnpNCT/6g5KyGcSTQYkmAZi4aTghVNEbHgQvEDjz6vqw
	0x7HMHsjFEonK3aPKyCg7pfQH4MY/mj3hd+m+rLcknE3U0kakrM8VuTrtpU6G3ayWB/zJuKPtLQ
	jCyFSjcS/zE5sbXnC7IN8wum7Tc=
X-Received: by 2002:a05:6a00:3c86:b0:81f:40e5:34c2 with SMTP id
 d2e1a72fcca58-82f8c8bee9dmr24460114b3a.32.1776882602100; Wed, 22 Apr 2026
 11:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
 <20260421172500.1050754-1-asas1asas200@gmail.com> <a396cf77-81ff-45a7-ae62-fb4e22c18497@oss.qualcomm.com>
 <5209fd4c-eee3-46ed-b731-1e822a04b03b@oss.qualcomm.com>
In-Reply-To: <5209fd4c-eee3-46ed-b731-1e822a04b03b@oss.qualcomm.com>
From: =?UTF-8?B?5pu+5pix57+U?= <asas1asas200@gmail.com>
Date: Thu, 23 Apr 2026 02:29:49 +0800
X-Gm-Features: AQROBzDxM0fqbCHkhOTTojJKKrEQPg26v2Vc1sqEZ8FbcRGZeJNS3g34dPnWJWI
Message-ID: <CAJo1PWGuSk4te+XVPn2cxqHpc1RfBfZbeKbtXm=8OZQ=rf_wpA@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath12k: fix false positive RCU warnings on PREEMPT_RT
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org, 
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>, 
	Rameshkumar Sundaram <quic_ramess@quicinc.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 06:33:45 -0700, Jeff Johnson wrote:
> Amended patch in my pending branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=3Dp=
ending&id=3D32f70ee38388bb9089b9cffa9791f5ef8d5d32cd

Thanks for picking it up and fixing the Tested-on placement.

Sebastian pointed out on v2 that the fix should use
lockdep_assert_in_rcu_read_lock() rather than RCU_LOCKDEP_WARN(),
since the former is gated on CONFIG_PROVE_RCU (same effect) but
expresses the intent more precisely. He also noted that the bug
is not PREEMPT_RT specific but applies to preemptible RCU in
general.

I've sent v3 addressing both points:
https://lore.kernel.org/ath12k/20260422180814.1938317-1-asas1asas200@gmail.=
com/

Let me know if you'd like me to do anything further.

Thanks,
Yu-Hsiang


Jeff Johnson <jeff.johnson@oss.qualcomm.com> =E6=96=BC 2026=E5=B9=B44=E6=9C=
=8822=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:33=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On 4/21/2026 2:27 PM, Jeff Johnson wrote:
> > On 4/21/2026 10:25 AM, Yu-Hsiang Tseng wrote:
> >> Two functions in ath12k assert that the caller holds an RCU read lock:
> >> ath12k_mac_get_arvif() and ath12k_p2p_noa_update_vdev_iter(). Both use=
:
> >>
> >>     WARN_ON(!rcu_read_lock_any_held());
> >>
> >> On PREEMPT_RT kernels built with CONFIG_PROVE_RCU=3Dn, this produces a
> >> false positive splat whenever these functions are invoked from paths
> >> that do hold the RCU read lock (e.g. firmware stats processing or
> >> mac80211 interface iteration).
> >>
> >> Root cause:
> >>
> >>   - On !PROVE_RCU, rcu_read_lock_any_held() is a static inline that
> >>     returns !preemptible() as a proxy for "in an RCU read section".
> >>
> >>   - On PREEMPT_RT, rcu_read_lock() does not disable preemption. A
> >>     task can therefore be preemptible while legitimately holding an
> >>     RCU read lock.
> >>
> >>   - Callers such as ath12k_wmi_tlv_rssi_chain_parse() (via guard(rcu)(=
))
> >>     and ieee80211_iterate_active_interfaces_atomic() do hold the RCU
> >>     read lock, so these warnings are incorrect.
> >>
> >> Typical splat seen on a WCN7850 station with periodic fw stats
> >> processing:
> >>
> >>   WARNING: drivers/net/wireless/ath/ath12k/mac.c:791 at
> >>     ath12k_mac_get_arvif+0x9e/0xd0 [ath12k]
> >>   Tainted: G W O 6.19.13-rt #1 PREEMPT_RT
> >>   Call Trace:
> >>    ath12k_wmi_tlv_rssi_chain_parse+0x69/0x170 [ath12k]
> >>    ath12k_wmi_tlv_iter+0x7f/0x120 [ath12k]
> >>    ath12k_wmi_tlv_fw_stats_parse+0x342/0x6b0 [ath12k]
> >>    ath12k_wmi_op_rx+0xe9e/0x3150 [ath12k]
> >>    ath12k_htc_rx_completion_handler+0x3df/0x5b0 [ath12k]
> >>    ath12k_ce_per_engine_service+0x325/0x3e0 [ath12k]
> >>    ath12k_pci_ce_workqueue+0x20/0x40 [ath12k]
> >>
> >> Replace the WARN_ON() with RCU_LOCKDEP_WARN(), which is gated on
> >> debug_lockdep_rcu_enabled() and therefore compiles out entirely
> >> when PROVE_RCU is disabled. PROVE_RCU kernels continue to get the
> >> full lockdep-based check.
> >>
> >> Fixes: 3dd2c68f206e ("wifi: ath12k: prepare vif data structure for MLO=
 handling")
> >> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.=
0_SILICONZ-1.115823.3
> >
> > Note that Tested-on: is not a official upstream tag, it is an ath-speci=
fic
> > tag. Since it is not an official tag, it should be specified separately=
 from
> > the official tags:
> >
> > <commit text>
> > <blank line>
> > Tested-on: ...
> > <blank line>
> > <official upstream tags>
> > Signed-off-by: ...
> >
> > Unless there are are other review comments there is no need to send a v=
3 to
> > address this -- I can make this change when I pick up the patch.
> Amended patch in my pending branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=3Dp=
ending&id=3D32f70ee38388bb9089b9cffa9791f5ef8d5d32cd
