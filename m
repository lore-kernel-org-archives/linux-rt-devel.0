Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E454D2F5313
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Feb 2026 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772049969; cv=none; b=GEPP9ucBjTpEM9veyRY+ZO6LeUGsVcKUPYqABfI3XGqkiEcQQZlodzXQ5T7yjqZnl+TtpNs03hmKMqBAHQI4kMX6pWwdu6kDwfwP5XRd/Y9jNDHpWZi10iz3CG/6fM5xeRe7i2zEtd7fjcGoGkLnfj6jizJqqwCsWoBoE+Z8RXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772049969; c=relaxed/simple;
	bh=m0jI+91ZfLMP+Bf2OhJVOZYQ73gUlZTgUnjRJsTmi04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsZLBrMHuh7hMU3H6DoZHHr6L/76OvA2g2TlpF57LDRIx1WAa/aza+dcsl9uNnlGGiVPlrYWvXU/8NvRAn0ptubklRTxeU+aR+Z6X1YtdQOY2/0H5aMSEDnz9xJ5bCmqgiuplGh4i37xCg8IP3wA4jGDfW0gdrX38Mfg2HWBKu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=KLcHkTGB; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="KLcHkTGB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1772049966;
	bh=m0jI+91ZfLMP+Bf2OhJVOZYQ73gUlZTgUnjRJsTmi04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KLcHkTGBMUGND86ai4aFWFeAjsLPti++nW7JDWlKH+BQNsiodRppa8+u0WdJZ0+l8
	 bGko4om0ckOPqghTw7mAYTihVNP4aNHyfdLD5nEPI5+F3cqVZfSvTkAs8xcGlw5J7a
	 plExoI4dFGc1uKlUL1d8r3LcXGPoNydB06w+QV9vMp/R+ui/tLvVvWrh8x4m4ksfYO
	 de9JHs66rjkPRcFygnfusWlMwpkBQx1Xx9uRcF5/xS8BkcjVl0yhwEHfNXvEiR2VkL
	 moKlYzmi4WY2zDPO3z0yRKaFtCcw3JgAnylFUERYYh8y9VGjPWbx5zMAADJ1wAELpI
	 HW5uMgTVwflfg==
Message-ID: <7ee8b784-a714-4329-aab2-a571f25c3baa@lankhorst.se>
Date: Wed, 25 Feb 2026 21:06:05 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [i915-rt v6 00/24] drm/i915/display: All patches to make
 PREEMPT_RT work on i915 + xe.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-rt-devel@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20260220083657.28815-26-dev@lankhorst.se>
 <20260224162703.Q_taYjEC@linutronix.de>
 <20260224165903.2mn24oQy@linutronix.de>
 <20260225075806.XNtXjZ5E@linutronix.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260225075806.XNtXjZ5E@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey,

Den 2026-02-25 kl. 08:58, skrev Sebastian Andrzej Siewior:
> On 2026-02-24 17:59:04 [+0100], To Maarten Lankhorst wrote:
> …
>> This one I can reproduce while opening a browser and surfing a bit. Let
>> me try step by step without lockdep, without RT and maybe just play
>> v7.0-rc1 to figure out where this is from…
> 
> It triggers without lockdep but takes longer. It does not trigger
> without RT so far. I will try to narrow it down later unless it is
> obvious where this is coming from.
>  
> Sebastian

After realizing the uncore lock only needed to be converted to a raw spinlock
because the testcase was broken, I tested the alternative fix of using
sleeping context only in the selftests:
https://patchwork.freedesktop.org/patch/707063/?series=162145&rev=1

With that the reset selftest works as expected.

But I do see some weird lockdep splats and aborts after that fixed the uncore lock testcases:
https://patchwork.freedesktop.org/series/162145/

I believe it could be a different instance of:
https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_162145v1/bat-dg2-9/igt@gem_lmem_swapping@parallel-random-engines.html#dmesg-warnings904

Which is tracked under:

https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15759

Perhaps those are related to what you are seeing?

Also don't use that series for anything but CI results, I rather want to submit
a new version of this series.

Kind regards,
~Maarten Lankhorst
