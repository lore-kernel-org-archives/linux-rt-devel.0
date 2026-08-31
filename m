Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90144477E3
	for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193492; cv=none; b=a5uA43U92cUNCR0p6bJNKG+kZwz4kmmg7KWhk+Ne+4H8jmS0AZAB/uyfZG7D2if9udipGw+we1CASXPE0Ah7dadGIPiBqvQGGsB0Ziro49xPD1Z3LtvB3gpWEUxhMkpt/6j8TdYLEjVpuiy4inA+He5F3zUrEWzz2J4m0JHOxg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193492; c=relaxed/simple;
	bh=4wASPUEGd3KOv6Fdubi246q8cZj4P8D3ytyUATn9DWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hH7vbVQq8jDKLnDEn1KMSTtCbTRr7AGhEvpSivXt91t57vLlDd7qrjZ/UCeo7EfXtxhVkq0ZsnFLgvO/U2MIHmK1ZUfsgo0l7sXB7/sijgpz4kAqoRStVj2qjTLDszqVAhIFn70cC3lu5murNETyOBWizZXPniPIiFJOM+SXrVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaM4xafD; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaM4xafD"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3964e76d0f4so3928090a91.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 09:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788193490; x=1788798290; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4wASPUEGd3KOv6Fdubi246q8cZj4P8D3ytyUATn9DWg=;
        b=XaM4xafDI3UJdTxNnMvTLQaTLkCnNxu6H7+vYvDVF8BtwdEK+bnTkRe7xe5KHjdxne
         +4ln7mtOFYyicR0mnVGX+pLgguKVdY5EgxDNp74sOxGmbmyAsFyhzzDyY2EFoTOZmId4
         XS5u2OVebdBQn7oP7mHwenFSlqYP6ltkPuMgYwBl8mcNmvAT1JDaaVKPyyLZAqzk6Vav
         zzDRfuVrUahs6P8Vlq3ooonA9elXSnMt7Q1QThAGT9HT0HPpLLj6ulMiq8Z+E3n+4cec
         zUwUsOcuFaiIf9o+dRaPPBuZ9BuNoPQOprAq57I0S4jWan7tdX7AU37vx3rioDsQl9En
         HYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788193490; x=1788798290;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4wASPUEGd3KOv6Fdubi246q8cZj4P8D3ytyUATn9DWg=;
        b=TwoW94XMrdKucXljXHiRCqMFORpICH3oSeUlh/nSssWX21zjLGNEennvrTPHdAEW/B
         yXy+JVEnnBReLzNDPfimFR/LRyuE2eVJZl3vY8kFvY6wA0JyMiHAKrxIKeh66LrDvVEt
         XcvzPBLs9gSQQ6rZWVi/pdNsVfmeLLTto/wsGw/39WlqXtionLfV80ria6QwN9skMYWW
         wtUv1EWa3BquqEHULtq6ZMe8BMi8F3hjGR85mhufr+7W8LcCQiAqz0tHK2bcRvBD0KTT
         N0cFJsePyXj+qpTrfxSNTs3eoSfkWR/At8a7ga+5lyQUEmvNaoRgub/92/AYnq6B8PiF
         gvUw==
X-Forwarded-Encrypted: i=1; AKwUvByqm3rma7fiBiyqN1x/1lbY4lJv/XC1tLCHsnfaXIY2NN3kyy54N+pTYxpLoOzeo1ViOz1UDreavCCAuOr3Vg==@lists.linux.dev
X-Gm-Message-State: AFuF++nZyCqpOSZP46voH5aDQd8DwP0t+iSopR3EWYYv3hvxBzefz0HV
	iCzQDtdbjmxa0f6votlFrfwpU5FAeoDgzHcd3GAkc9GU48vuggZ9pTay
X-Gm-Gg: AYBFou2TwnfBM4DZdF67liyEpezYQiAJUkdetOAQdc+zCL+vqK6VhkOziIUPMk3vt2/
	iEHvz4KxaEGX5TJ3WYES2p2A//SSh6vI+65UW0NIh9fjPCjNB8NCuDWWrwf9mlDJrBvvvPrIBKe
	zvNj/t7VXc+JeRN/YgmZ3HoDWvRwTBVb9FQs19Pd8hR+HzZyeh3qiRg1m09THSlGckUhaBTojQY
	C7a7/hqMZi24fePJ67E9hBz7oXXxFMuCY0jVwqogyqOGRVg+6fuE1m8S+lcZfCuHaiK/uGB53BL
	IiJEQa67mT5yC4pJGsv+1Rf6tk1an1Ie38cO+6oIMdp4EAx9QNQd9HKe/CZ+qHNOHBPoDhUUYPN
	yTYkkC8UJbw2lQpINRB7gg/ae/6WTSqxZf9rktrq/cYgxJSR1jZfGn1oM7kR644QxhVSVP6cdmC
	icY+bMCr4gTMPFeeLA0NuH1uM9pJ020X8HLJdtn4a7pHRI4qwcqwOEld+ujo88/euYL4m00YF2z
	oDv336w
X-Received: by 2002:a17:90a:e185:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-396d0ecbdb9mr45635347a91.6.1788193490095;
        Mon, 31 Aug 2026 09:24:50 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:21dc:72d0:a033:17f7:ad44:4f35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990c40d0c9sm311768a91.7.2026.08.31.09.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:24:49 -0700 (PDT)
From: ThangNN99 <ngocthang2710.1999@gmail.com>
To: Vlastimil Babka <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	ThangNN99 <ngocthang2710.1999@gmail.com>
Subject: Re: [PATCH] mm/slab: disallow kfree_rcu_sheaf() on PREEMPT_RT again
Date: Mon, 31 Aug 2026 23:24:42 +0700
Message-ID: <20260831162442.8176-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831-b4-kfree_rcu_hotfix-v1-1-4f0fb882638b@kernel.org>
References: <20260831-b4-kfree_rcu_hotfix-v1-1-4f0fb882638b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks Vlastimil, this matches what I found and is functionally the
same fix I had in my v3. I built this exact logic (skip
kfree_rcu_sheaf() under CONFIG_PREEMPT_RT in kvfree_call_rcu(), same
dead-code removal in kfree_rcu_sheaf()) against commit 08dbfad3f504
with the syzbot .config and reproduced the original splat with
syzbot's C repro (writing "off" to
/sys/devices/system/cpu/smt/control to trigger the
__balance_push_cpu_stop -> select_fallback_rq ->
cpuset_cpus_allowed_fallback -> set_cpus_allowed_force ->
kvfree_call_rcu chain) — confirmed the exact same lockdep report as
syzbot, then rebuilt with the fix and confirmed the splat no longer
appears while the same code path still executes.

Feel free to add:

Tested-by: ThangNN99 <ngocthang2710.1999@gmail.com>

Thanks for picking this up and for the pi_lock/waitlock explanation,
that's a much more precise description than what I had.

ThangNN99
