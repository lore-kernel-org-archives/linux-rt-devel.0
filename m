Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB83288502
	for <linux-rt-devel@lists.linux.dev>; Thu, 11 Dec 2025 05:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765431787; cv=none; b=e/E7oVFfbRCO41XNamDr3+tPfwl2L8gGbZKm9AHQIQdT1qCAttXF1FRslM++kE/LUckZd0r+BKhDNEXvvGCxzQsXobeEsmlsGubr4tRm5o8FsGru9VxLMSiQEu/y3yIKcOw3mwCp1Ib1PXpPOJ3JdjQ3F/I6K/ohPHgR/vtN7ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765431787; c=relaxed/simple;
	bh=Q0Lwe9Tk18lJy/Oyhc4fzBDZpEBk1/ZN/rc1ufLM+s8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rzUhR4iar8qiikh9Br6qkt4lKSS/NhP68GcprjMI1pbBXdmhpwwiZetRQr2kdPEbuHBIGDFnoCdrpoYQ7IWSnvwoYBrgEWK/OKyu2qwruJ1oDp+7CQvfdteLjeyodrxBqI1tFn5pCyniP6CvKcW++h0oNaYLzVUbR5/jMpMWjsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nkmg/j/V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/Rl10JLL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nkmg/j/V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Rl10JLL"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765431784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N4/1FMN9XviyjV4pzpXIdtzEW3fhzfBdvAI15E9dHEQ=;
	b=nkmg/j/V6fF/tPl1hgasRCZyB2SXI5e4YbIfP4Zz3EGRsYuB3KhYib4BnoeOO+FZTC0NcT
	mCnr51ehpucA2+hcWraWAwsW5+WLS/MfpS89J3EoFnYYjq5u5D4MQvtJvMlt1iahY9fVLu
	r05To3Zm7WSnZciYyL6wBmVP1zTr5H9hWjm3RjNM23oGwkpRbBLUyXG/rDfKKWOInboUni
	vT98w0m+Y7Ww5E2353/ZiTj8M8gjzapcUAY6Bpgia7ngYHuxstjmvP3dItCFbCBEEiikui
	X6wgqvbbkvBaMonaI06uH2h0KShKqRDMRXXSCkdAoEe9CgvtUIZfH/8fNj6qjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765431784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N4/1FMN9XviyjV4pzpXIdtzEW3fhzfBdvAI15E9dHEQ=;
	b=/Rl10JLLtPjjdyBc2c3CBY+I4WiZxG3XjZMbgcnAmFlWuXD3+xWk/v43LVmvbNI9OzT3Y+
	8EGJ/WmcZwlLchBg==
To: Yunseong Kim <ysk@kzalloc.com>, Gabriele Monaco <gmonaco@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, rostedt@goodmis.org,
 Tomas Glozar <tglozar@redhat.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Byungchul Park <byungchul@sk.com>, syzkaller@googlegroups.com,
 linux-rt-devel@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>, Dan
 Carpenter <dan.carpenter@linaro.org>
Subject: Re: [Question] Detecting Sleep-in-Atomic Context in PREEMPT_RT via
 RV (Runtime Verification) monitor rtapp:sleep
In-Reply-To: <53f17978-40e5-4b2e-b719-552612b0e775@kzalloc.com>
References: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
 <87fraslu9c.fsf@yellow.woof> <87jyz5kuf2.fsf@yellow.woof>
 <20251202112644.YUux4LKd@linutronix.de>
 <53f17978-40e5-4b2e-b719-552612b0e775@kzalloc.com>
Date: Thu, 11 Dec 2025 14:42:54 +0900
Message-ID: <871pl1y3oh.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Yunseong Kim <ysk@kzalloc.com> writes:
> I specifically believe that RV can encompass the role of
> CONFIG_DEBUG_ATOMIC_SLEEP and even go beyond it.
>
> My reasoning is that even if a sleepable (PREEMPT_RT) spinlock is used 
> within an IRQ/preemption disabled section, CONFIG_DEBUG_ATOMIC_SLEEP 
> might not trigger a warning if scheduling does not actually occur (i.e., 
> if there is no contention for that spinlock). This is because the actual 
> debugging check happens in __might_resched().

That's not how it works. See the description of CONFIG_DEBUG_ATOMIC_SLEEP:

"If you say Y here, various routines which may sleep will become very
noisy if they are called inside atomic sections: when a spinlock is
held, inside an rcu read side critical section, inside preempt disabled
sections, inside an interrupt, etc..."

Nam
