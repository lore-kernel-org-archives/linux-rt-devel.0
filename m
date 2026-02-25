Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E37261C
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Feb 2026 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021714; cv=none; b=aY3WAyIVHkpN8nXJPuE36XLTICRXegUUh9VJ3KSBuuqsPqnymbu5PsA2AX4Kmj6eagcb3KIwVy8zrFb1VV1zUYn3rLlNgipkFivYWlGC9K1+uXR+WOIRZySW/inRDtimlOA1+xywYnAw5W/xoGCbO9XMC0+6rKkW932piJNFiTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021714; c=relaxed/simple;
	bh=PJiUDFQ1DQQRZwqKOW72XNDSnj66CFtkXC+fGy1J9rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5zld8V2uy924fPvoino1jhlqGqHSPjGuWK+LLXlKFCZDc6sTiBehrjzNjTAFCFhkvYAANg8AJUH8Zu6S34CLlqTkfPVzi3tEr2t8yIa4QjlOxfuU4HFkfp0BioBqHbYWmbojjwl0RBpR6Bt/w3hgLWfhwQX0NzlC5zhg3bJzxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=m5rL2tlG; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="m5rL2tlG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1772021710;
	bh=PJiUDFQ1DQQRZwqKOW72XNDSnj66CFtkXC+fGy1J9rU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m5rL2tlGFQZ+wBp4VoGsrmq6W3b4cvSwTo07KIORZPboWl7VGRWisLl1IaeRI5nPQ
	 L9wAc93rlKMr3BnXJ342Cm0fgN6lbPBuj/OAvyV+D0Llvuaoe0V769CXkq9PYRU83Y
	 Bqwxk5CVIIh6U03QExSQWVEnkLKoB3HYd1RVbkJeVsme3covhWs61L8GK5ObP3qrZa
	 urQHxZbkq/NK5j3qp9/bOHv0ixRQnDyaqq0derSbOWttD+c6z16psNeo76q1Sdw7jZ
	 wLTddEat62yFlrN7KW34m4RrL/gy4hc9HRV3op4JKVfovu8gef76d674e5MZNtlBOK
	 HzTJKaGOsQkBw==
Message-ID: <d5039bbd-0eee-4057-b643-67633150eb24@lankhorst.se>
Date: Wed, 25 Feb 2026 13:15:09 +0100
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
Personally I've been running this entirely on xe, and it in stability
it is comparable to !PREEMPT_RT.

I didn't entirely fix i915 yet. The changes I've made are the changes
from the PREEMPT_RT tree, plus what I found when running the submissions
against CI.

The most likely problem is that the uncore lock needs to be converted to
a raw spinlock. I postponed this, as I have been focused mostly on
display and then especially the vblank bits.

The selftests failing are very likely related, GPU reset is probably
broken on i915 if I look at the CI results.

GPU reset failure:
https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_159035v12/fi-cfl-8700k/igt@i915_selftest@live@reset.html#dmesg-warnings533

I'll check what happens if I convert the spinlock to a raw_spinlock.

Kind regards,
~Maarten Lankhorst
