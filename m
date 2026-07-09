Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647D54723;
	Thu,  9 Jul 2026 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607933; cv=none; b=eIf0cQOX6cDt97j6RhGRCQGOzUxAQFWxv19jOOhhMsAynHCCjFFBCQ7rECJ1VSyj6gQrrY7GTPJNR1VXFcC+gRxvYPzSoWpYKFezyasGH0Z3MONM8B83ZH4l6mnGCRSLcfOLiBKxW7zPXTZnVe4AqESLMgWTMYh4MtsQTKNjde0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607933; c=relaxed/simple;
	bh=J5qEk6mSl3WKm2EI0sieq0lLU0pyb6XdpMby7zTN5so=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aJ6zrTTWvpFEIzGHsmJ4hcELP3lm5q+MNU+NqEzbpnRlAUmKaYArDvkbmwX5JJJPSbn1cqz4/exbLwGPWNiEvvgSAFpBrZhLTBGN/b4LQ5GCcuSylnSD2lJ6VpCp7UomMMCVzBG6KSIA92FfyjMM1oyO4O6h2UMYgW/FiPX09d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZJF0jqJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZJF0jqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8DB1F00A3A;
	Thu,  9 Jul 2026 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783607932;
	bh=VmcfCU9mg6cC+ttcEyqDVALq9F3di98UEhamxZdYAhY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IZJF0jqJcAFWtyAazX3TlNJFqZ8lAoZCoTQHf9BfkHG9ZYMqKWhZ+GSZDrzzuSeA2
	 jcHZ7iAdY47cmw0flo5aiBf60hM70JXtkj+nwt1YTWYoZAHVQoX2miikNSK/RTzjIb
	 hiY5JoHLag9XKUFIRZ5B0dkq1i8PcpP1sl+2KbuvOtGyZAe4d0fdvOzI42qsAIiDnd
	 FgcRUx8okC1Z0+B4SCplr0HXJeeddVY2rHbSnc/sA2RM6yqGJCH+Pei21O24YIi1Mt
	 /bB8MhbAkr/iiK2V9/yJrgG+Hd/oDVjwcrRENH0GdnqX51+iKkphMzSnl8m5GJGUZi
	 USUr+/BTajUsg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260709143108.UYeCUUcd@linutronix.de>
References: <20260709143108.UYeCUUcd@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:38:51 +0000
Message-Id: <20260709143851.8D8DB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Creating `/sys/kernel/realtime` as a regular file prevents futur=
e extension into a directory, permanently locking the ABI.
- [Medium] Exposing a single-purpose boolean flag instead of a generic pree=
mption model indicator.
- [Low] Newly added sysfs show function uses deprecated `sprintf()` instead=
 of `sysfs_emit()`.
--

--- Patch [1]: [RFC PATCH] sysfs: Add /sys/kernel/realtime entry ---
commit b40fad0ff776ab9c6dbe7fb2b7d2cb062431ad56
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

sysfs: Add /sys/kernel/realtime entry

This commit adds a /sys/kernel/realtime entry that returns 1 when PREEMPT_RT
is enabled. This provides a way for userspace tools like udev to quickly
evaluate if the system is running a realtime kernel without parsing uname
output.

> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> index f45ade718054a..670a7a57d7b23 100644
> --- a/kernel/ksysfs.c
> +++ b/kernel/ksysfs.c

[ ... ]

> @@ -133,6 +133,15 @@ KERNEL_ATTR_RO(vmcoreinfo);
> =20
>  #endif /* CONFIG_VMCORE_INFO */
> =20
> +#if defined(CONFIG_PREEMPT_RT)
> +static ssize_t realtime_show(struct kobject *kobj,
> +			     struct kobj_attribute *attr, char *buf)
> +{

[Severity: Medium]
The commit message asks if there are better solutions to express this state.

Instead of exposing a single-purpose boolean attribute specifically for RT,
could this be a generic preemption model indicator like
/sys/kernel/preempt_model?

The kernel supports multiple preemption models (NONE, VOLUNTARY, FULL, RT,
LAZY). Providing a unified UAPI that leverages the existing
preempt_model_str() for all configurations might be more scalable for
userspace tools than a dedicated boolean file.

> +	return sprintf(buf, "%d\n", 1);

[Severity: Low]
Should this use sysfs_emit() instead of sprintf() to align with modern sysfs
API standards?

> +}
> +KERNEL_ATTR_RO(realtime);

[Severity: Medium]
The commit message mentions a past discussion about adding
/sys/kernel/realtime as a folder. Does creating it as a regular file now
permanently lock the ABI?

If future realtime features need to be exposed individually, replacing this
regular file with a directory later would cause a strict ABI breakage. Exis=
ting
userspace tools calling read() on it would suddenly receive -EISDIR.

> +#endif
> +
>  /* whether file capabilities are enabled */
>  static ssize_t fscaps_show(struct kobject *kobj,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709143108.UYeC=
UUcd@linutronix.de?part=3D1
