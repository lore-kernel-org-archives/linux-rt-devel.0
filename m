Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CED155A5D;
	Sun, 11 Jan 2026 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124351; cv=none; b=XrZHX1RN8YoJFU1IlJk0vVWKRn5o/VFYuq2JB2FyYpDOApVWC7SCdPbhSxgJRGPP5Bj96bvvW6zj4HTHhdIT8cad1ZkDLMvIZ3bu8hcBQ2tZP9QJxfuKUO0b7977uYhp7PTGl8LNik/R3rxfqIiSfdwd5jOsbKKZYGw32FhMqjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124351; c=relaxed/simple;
	bh=aW0CKm78TXJY3BMiQ9I1oxayXIOYf/OmUdlBeqOFtnk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u98tI2tGVhtUiwlL+JiaRwPoJnKO8xxlZg3ilGQYJFHph3/DOTDbuO1VMgsGcHQ2/3xPZ6aC5ibl9KCa6YV26n8X1ZCcgY4Hi1dUTTyJmf8hO06VQkVBdBxpNlljNAGV4FZ/KUP3/kIpDOW2b3cWk9BYCjHIQMeyi8mVWLT94h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cho7Hjzi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cho7Hjzi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C72C4CEF7;
	Sun, 11 Jan 2026 09:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768124351;
	bh=aW0CKm78TXJY3BMiQ9I1oxayXIOYf/OmUdlBeqOFtnk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cho7HjziD8w7WwL8AxcEbVjRqlZee/4T7QpW9RCc9XbE9uFowp3c67CfKFmedvKsd
	 R6o3Wx1Nb1D9Kfhb2YC2nETOPZaT1bJ0e/pwNjVJ9dZs2QMZpB19y15C7+z16FzyJi
	 LsmOq7rnqVQxoTSxE+TX3rFuyVLyLLFOt10gva6QvFzGGO2paBN8+ykP7IGmHcVIhR
	 d68mDvkxhN110U0zXkIV7eMAzQLEfoB7sTqh0qP4eDkA+KKzhQupgF/ec97cJ3Qoil
	 4DzOteFEOO8Dumbi6x2yP128Zmorob8Rwl6LZItHmjrIC5UnpkCjGkh0g5ES9Z2HNv
	 NRPSov4m3Srlg==
From: Thomas Gleixner <tglx@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't acquire rt_spin_lock in
 allocate_vpe_l1_table()
In-Reply-To: <86wm1qlq7l.wl-maz@kernel.org>
References: <20260107215353.75612-1-longman@redhat.com>
 <864iowmrx6.wl-maz@kernel.org> <87ms2nsqju.ffs@tglx>
 <86wm1qlq7l.wl-maz@kernel.org>
Date: Sun, 11 Jan 2026 10:39:07 +0100
Message-ID: <87ecnwij44.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jan 09 2026 at 16:13, Marc Zyngier wrote:
> On Thu, 08 Jan 2026 22:11:33 +0000,
> Thomas Gleixner <tglx@kernel.org> wrote:
>> At the point where a CPU is brought up, the topology should be known
>> already, which means this can be allocated on the control CPU _before_
>> the new CPU comes up, no?
>
> No. Each CPU finds *itself* in the forest of redistributors, and from
> there tries to find whether it has some shared resource with a CPU
> that has booted before it. That's because firmware is absolutely awful
> and can't present a consistent view of the system.

Groan....

> Anyway, I expect it could be solved by moving this part of the init to
> an ONLINE HP callback.

Which needs to be before CPUHP_AP_IRQ_AFFINITY_ONLINE, but even that
might be to late because there are callbacks in the STARTING section,
i.e. timer, perf, which might rely on interrupts being accessible.

Also that patch seems to be incomplete because there is another
allocation further down in allocate_vpe_l1_table()....

Thanks,

        tglx
