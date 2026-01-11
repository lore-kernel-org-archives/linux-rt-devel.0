Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C23314F70;
	Sun, 11 Jan 2026 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768148450; cv=none; b=dGNc3so+GWvFgHWgLZ+gUEyDjsJFzGbd4aVWm/QZ3URz1eF3+BZ0CEwFDqYRZnWKy2rXJT8zDu/cvoxdmmnwswfIsUkBotVZ18uzQbEjW2yc90SB1Rot6pmF52Cq4FYV1ZTX6Wi54QYPcDjfoSqmDS12Tmnxq913LBkAllZTB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768148450; c=relaxed/simple;
	bh=XxASkA9n76GnwdXuy4myQ5dyLLeDuGEtOKbjql8OspE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N85cQudkjGYVvOxnS/5spKY3g5py2O9WbQBUQo1VQd0itlfwGFy0ep0kbybfwBj2Xt8iVapPpReP0VMArh9H8pmLb/3aNQd7Mt8WIs0jwmL3o6Wum0a3NdjHrve1+TVREva4y/xAvfeb/YhU7NlqZk8CB874RHPiIu5RceqxuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WI7bynz5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WI7bynz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3493C4CEF7;
	Sun, 11 Jan 2026 16:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768148449;
	bh=XxASkA9n76GnwdXuy4myQ5dyLLeDuGEtOKbjql8OspE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WI7bynz5q61zhbhcxgLoZgd735Qm/pJNbIxIV6+NNY3x2kTRnlHiFMUbmLEayjxq1
	 yWVOHyHZjv8Pl4e1cwdFgcfFddfw6n0xvOnqJyleyW/500rO8uAUH+VyB5fmRpxmdV
	 HnPBZyNHF+UqiOUxFDj/g+N1rf+k9gVtH2Hg9R2tDrTM3aCTLcWrw+bi7JNU7SSgJz
	 2GZH9JGLIuf/5hkcm/BZuC+ipi+gXUp+1aOc58IE2dkklwrgTokLMwqBRuJmk7S9T/
	 IdwcvOrAMsz0eKBHbRt2xLQfMun//6P6432sG637lpF+oChtvkkrvioKSqTfEuG+xq
	 xypiuRQ1P3eww==
From: Thomas Gleixner <tglx@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't acquire rt_spin_lock in
 allocate_vpe_l1_table()
In-Reply-To: <86v7h8l9ht.wl-maz@kernel.org>
References: <20260107215353.75612-1-longman@redhat.com>
 <864iowmrx6.wl-maz@kernel.org> <87ms2nsqju.ffs@tglx>
 <86wm1qlq7l.wl-maz@kernel.org> <87ecnwij44.ffs@tglx>
 <86v7h8l9ht.wl-maz@kernel.org>
Date: Sun, 11 Jan 2026 17:20:45 +0100
Message-ID: <87pl7gglya.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jan 11 2026 at 10:38, Marc Zyngier wrote:
> On Sun, 11 Jan 2026 09:39:07 +0000,
> Thomas Gleixner <tglx@kernel.org> wrote:
>> 
>> On Fri, Jan 09 2026 at 16:13, Marc Zyngier wrote:
>> > On Thu, 08 Jan 2026 22:11:33 +0000,
>> > Thomas Gleixner <tglx@kernel.org> wrote:
>> >> At the point where a CPU is brought up, the topology should be known
>> >> already, which means this can be allocated on the control CPU _before_
>> >> the new CPU comes up, no?
>> >
>> > No. Each CPU finds *itself* in the forest of redistributors, and from
>> > there tries to find whether it has some shared resource with a CPU
>> > that has booted before it. That's because firmware is absolutely awful
>> > and can't present a consistent view of the system.
>> 
>> Groan....
>>
>> > Anyway, I expect it could be solved by moving this part of the init to
>> > an ONLINE HP callback.
>> 
>> Which needs to be before CPUHP_AP_IRQ_AFFINITY_ONLINE, but even that
>> might be to late because there are callbacks in the STARTING section,
>> i.e. timer, perf, which might rely on interrupts being accessible.
>
> Nah. This stuff is only for direct injection of vLPIs into guests, so
> as long as this is done before we can schedule a vcpu on this physical
> CPU, we're good. No physical interrupt is concerned with this code.

That's fine then. vCPUs are considered "user-space" tasks and can't be
scheduled before CPUHP_AP_ACTIVE sets the CPU active for the scheduler.

Thanks,

        tglx
