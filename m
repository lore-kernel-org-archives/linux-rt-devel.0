Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DCD2D7810;
	Thu,  8 Jan 2026 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767910297; cv=none; b=VlMdDcr5c/EDFrVjOiINqNdY3W+8J4N0aPUcK5jkFNT4druqu4uk2ddDWmX6aiETbYSAxUd94L/ma/DTIluxp/yQJDeZ8QytNegnL2j1V9rCdNCHOcdHxCJcM13rmAZc+kj1xEmgBapxo16K//AMjgI34l5zKTBcI7fILtS16WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767910297; c=relaxed/simple;
	bh=OzHtw4j1Hs0u/sB/+AK8QyJAGm8BaIB2L3o2cUocQfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GfOfUcVlthcoQhaHoQxEiUaLa6T8WvaiWJ5rupMVmqaKlZGIsa8jifoVmuNJpc8KnYrM+nYJxX1uHZU9rxsSfzxU401c87vVzauy0/MoHFg3+sRDY7wbHe1IQDUd7CTfFMlrgMxTUgnHyL2SnNh5DFWJChLId/DbWesCFNzypYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0utsSnh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0utsSnh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8687DC116C6;
	Thu,  8 Jan 2026 22:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767910297;
	bh=OzHtw4j1Hs0u/sB/+AK8QyJAGm8BaIB2L3o2cUocQfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=i0utsSnhzOYxUmd3u04lOOehC9ehc0ewEP7S0C5qBxZgTMySISjx6VuMguuOlEW61
	 1Jrtd2roEkaqN7G5DPTxJX9dluOoD3pxzw7ghgl3oGv2pYMbWcxefr5j4/rxPaao63
	 ZJdkTartSJ/Md2NME2wrvFgoz8nt2u6LLnlGHw9m3ITqO0CY3kZI2eh6kbUvsvO6+9
	 MY4xemfwU6N90+5h2II+ny+THvkgaUTdUfsZZKuDlxPUt3oRL9s5LoqJpZPHmzlalN
	 DTFWs3Nz7dCdE8MqbaBZC/ady7yOsHTO+NMrwDrioCNo2Q6efIu5fwqprJVwWNIgDa
	 3Nw3c/kgZHWuQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Waiman Long <longman@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't acquire rt_spin_lock in
 allocate_vpe_l1_table()
In-Reply-To: <864iowmrx6.wl-maz@kernel.org>
References: <20260107215353.75612-1-longman@redhat.com>
 <864iowmrx6.wl-maz@kernel.org>
Date: Thu, 08 Jan 2026 23:11:33 +0100
Message-ID: <87ms2nsqju.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 08 2026 at 08:26, Marc Zyngier wrote:
> Err, no. That's horrible. I can see three ways to address this in a
> more appealing way:
>
> - you give RT a generic allocator that works for (small) atomic
>   allocations. I appreciate that's not easy, and even probably
>   contrary to the RT goals. But I'm also pretty sure that the GIC code
>   is not the only pile of crap being caught doing that.
>
> - you pre-compute upfront how many cpumasks you are going to require,
>   based on the actual GIC topology. You do that on CPU0, outside of
>   the hotplug constraints, and allocate what you need. This is
>   difficult as you need to ensure the RD<->CPU matching without the
>   CPUs having booted, which means wading through the DT/ACPI gunk to
>   try and guess what you have.
>
> - you delay the allocation of L1 tables to a context where you can
>   perform allocations, and before we have a chance of running a guest
>   on this CPU. That's probably the simplest option (though dealing
>   with late onlining while guests are already running could be
>   interesting...).

At the point where a CPU is brought up, the topology should be known
already, which means this can be allocated on the control CPU _before_
the new CPU comes up, no?

Thanks,

        tglx
