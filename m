Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D6726CE17;
	Mon, 12 Jan 2026 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230593; cv=none; b=HSNtC5UcL9zjeS96Zyrz1CXSursnEq5+uNsa+U53kyQUKTYfn4Xzja+AzfDTcKouHR1Npbe8+1L7uOmWmuYSm4OYpYq60YFEmi/oHB7KSLFB8Xj0uPM3EpNyuY5KafiIInkTM4cQ8bSNDet8sUnOO9t/Phfgai7ffV8HxyAYWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230593; c=relaxed/simple;
	bh=SLLkOQ5pxC+Xfk84C/8GnkXcwep/asaQqw3bn0kNW0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MvP1uZOHVM/bsd/IaUsFyrBJYXkTVdxHL6Q47iTdpbKDcqZPSYeaa6GkRVX7OgPeUNN3cnFpkDbu4D0fDd2VcOgXRzLGlHHP2co3k3qw0QEgVN6biTfhoEnbjmeUaWhSpWYatodt5Z9utj66L3UPdO1IgQqj07lfGB/QBwQS/nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoQG3MNb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoQG3MNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D25EC16AAE;
	Mon, 12 Jan 2026 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768230593;
	bh=SLLkOQ5pxC+Xfk84C/8GnkXcwep/asaQqw3bn0kNW0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PoQG3MNbzDflVzcD8PDZTq+p3TS6E4HKQMo/CnosiFbQgC6ToFRKjRh8W7BtW1j+/
	 F2KSeN0J1sO74fQ6WkQnw0BiRv8ROqBrIMdIVWheMozYjHI6Fe88+8sx/2B4fjbaEf
	 qwwfikKji8Hb4ug0YcpLbYkxhd+xDKj4aQOIMDihcCD9TpwkHW+9v50MVZDVewZ8py
	 tLJpx9mPsIE40lEtYy7JM+1OddpQsyjn+/uYdmku45XRrt1GqFs9NaqLWTwUAFxO1g
	 MsR87UOq+cSoYZl4w4cqDqfrBLgz3QhzeiBzadvBXCglJC47OiLn7KCxgO1fpGac3d
	 8tVNRQMSYv0KA==
From: Thomas Gleixner <tglx@kernel.org>
To: Waiman Long <llong@redhat.com>, Marc Zyngier <maz@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't acquire rt_spin_lock in
 allocate_vpe_l1_table()
In-Reply-To: <40cec799-f363-4642-969b-24f5a2d56dfb@redhat.com>
References: <20260107215353.75612-1-longman@redhat.com>
 <864iowmrx6.wl-maz@kernel.org> <87ms2nsqju.ffs@tglx>
 <86wm1qlq7l.wl-maz@kernel.org> <87ecnwij44.ffs@tglx>
 <86v7h8l9ht.wl-maz@kernel.org>
 <40cec799-f363-4642-969b-24f5a2d56dfb@redhat.com>
Date: Mon, 12 Jan 2026 16:09:49 +0100
Message-ID: <87cy3eg94y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jan 11 2026 at 18:02, Waiman Long wrote:
> On 1/11/26 5:38 AM, Marc Zyngier wrote:
>>> Also that patch seems to be incomplete because there is another
>>> allocation further down in allocate_vpe_l1_table()....
>> Yeah, I wondered why page allocation wasn't affected by this issue,
>> but didn't try to find out.
>
> The use of GFP_ATOMIC flag in the page allocation request may help it to 
> dip into the reserved area and avoid taking any spinlock. In my own 
> test, just removing the kzalloc() call is enough to avoid any invalid 
> context warning. In the page allocation code, there is a zone lock and a 
> per_cpu_pages lock. They were not acquired in my particular test case, 
> though further investigation may be needed to make sure it is really safe.

They might be acquired though. Only alloc_pages_nolock() guarantees that
no lock is taken IIRC.

