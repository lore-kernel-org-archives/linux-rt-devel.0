Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED04BAA09;
	Mon, 31 Aug 2026 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185028; cv=none; b=OAS0s8LaPhpM7xolubKo1F+VysBKURwEs3+giSQ403hZwsYfbGhcHk4AhHcl8GG5z4OUa6F2/HzwBFycAoWDz0SnCnpQOZNOLid0gn3X6YDkV5ydukvZg0Wlfyvv30brWlz5AlM+ixcjvLl8o1uo6yK9hirHsSuwgC3ZS0g3ZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185028; c=relaxed/simple;
	bh=yNTKZ1gEh2b/vXha+oKOsZE/GcNfhLewQ7JdBaCKgjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MErFZW1tFvS+jRl+CdVgrp6fuSlj9myg91DlyOHUzh/gRDA0eoWH772BbONZXlqQB/rJw5Hu70/JdV+elaRScAIuoCuu7TUry7qU5jjPC+z+5aVjLPDNJsb53V/CK95GCl/T36ZTjquu9TJAYT0Cxn9Gp+RXiyj8F2pX+xhNW9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC63ksHd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC63ksHd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C681F00A3D;
	Mon, 31 Aug 2026 14:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788185027;
	bh=1HX9TYQjgO/5hXmQFqlxHA27MLAvo/v6Sb6ISr7PR1Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DC63ksHdTNXpk1d7LsdZXGkJ4TqoesWNQd4cA0cdBSN2sTz5oarOWquXAAe7Xne88
	 x2+W0buRDqFXeuIdOYmT/SKvqfrbNwFHWN7ihOHDbZt+bSCqz67ja1m8+d/tMnrnTj
	 mIlGeZbmnVY1BH9bhtNYamzgigzi5iLBVI+JBqh4oCQQg783Gs7v5Iw7Ym0936oesb
	 BoOyDnrhCglt26iK1OImhRBZEsl1owvpJVF67euhl7waxIXyn09LKFp9Uc91hAJVmA
	 eZaBpydeKgXBFIkT7tX1ms8GB0huF8Q0Crk4ypZoD5NpaNrSRbRfh3C4iKZXcAZD/r
	 sWBaijMSt89kg==
Message-ID: <0849e5ca-6dec-4cf9-83ac-89ab08364044@kernel.org>
Date: Mon, 31 Aug 2026 16:03:38 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 06/10] Reclaim memory from blocked kernel stacks
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, David Stevens
 <stevensd@google.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dave Chinner <david@fromorbit.com>,
 Qi Zheng <qi.zheng@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Uladzislau Rezki
 <urezki@gmail.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
 Clark Williams <clrkwllms@kernel.org>, suleiman@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-rt-devel@lists.linux.dev
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-7-stevensd@google.com>
 <20260828133620._x2XfJR_@linutronix.de>
 <20260828135947.GU776954@noisy.programming.kicks-ass.net>
 <CAOiLmNHrbXeTY7zoNodmaZUoMWf+NgvGvZ_LjfWD-1sKAoiLeQ@mail.gmail.com>
 <20260829084901.GA776954@noisy.programming.kicks-ass.net>
 <apLxcg3Lgy0-nXA4@casper.infradead.org>
 <20260831073619.Ssq-wt7s@linutronix.de>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSNWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBrZXJuZWwub3JnPsLBsAQTAQoAWhYhBKlA1DSZLC6OmRA9UCJPp+fM
 gqZkBQJqFFy6GxSAAAAAAAQADm1hbnUyLDIuNSsxLjEyLDIsMgIbAwUJGtCBUAULCQgHAwUV
 CgkICwUWAgMBAAIeBQIXgAAKCRAiT6fnzIKmZJIUEADFx/tREzUImHrEwVHeSvDFmA7tJysI
 UVrlvrM09E7GIuzphzv7jYmo8n3ANpCczLEVr4G0syYQdTigaZgv3+FQDIIzhKih1IHhu1Ei
 XHlywNWKnQxxQEUNi5Mwx43wQz5XVw9F1A7gtKBKNtfogO511hAbrzagrYajyQacEJ/+sfhZ
 9Da8ltHIXD8pcYaHUfQgEusCgmEd9+KrUwrTbckFKmYq5chuE6yJ4J0EmWknL096jIE6CnzF
 FRslQ3B1UKDjxVsm1ZHfir5NeWszLkTvGFsddFaWTgh8UycESG6VQzKXjjewXu2pG7YQYRpj
 QKm1W5X2TkwWkXRBZTmfmbhxIUMh3+zf5wQ463rSmDN/8v81tdqBtAW6rH/kzg1GvkaTHXn0
 507yEHFzBksk2viAuIxxr7km8+/KARYLIdGtx30EG8cKzAUZOK6WqxtNCsXUJNrVE8CWrCaD
 icoNu7Fs1c5hmPHdSTnU48ce67449DdnO4neLSNhRiGlMHJgfJUmgrxu/hcYeOZ3haWmEQ2w
 uW1Mh01OHi8QZHCEyAbABrPs9GUgccc/4eYXX9hIgxfSkYzn8f+8NuIFPWl/0uTvjgqU29FQ
 SbzOLxHq9439Ox40G5mS5eZXRGxITYR+6TXvRGI6P/264jvflnr/pDGUttaikU+0W+1uxgKH
 cmYbEc7ATQRbGTU1AQgAn0H6UrFiWcovkh6EXVcl+SeqyO6JHOPm+e9Wu0Vw+VIUvXZVUVVQ
 La1PQDUi6j00ChlcR66g9/V0sPIcSutacPKfdKYOBvzd4rlhL8rfrdEsQw5ApZxrA8kYZVMh
 FmBRKAa6wos25moTlMKpCWzTH84+WO5+ziCTsTUZASAToz3RdunTD+vQcHj0GqNTPAHK63sf
 bAB2I0BslZkXkY1RLb/YhuA6E7JyEd2pilZOrIuBGl/5q2qSakgnAVFWFBR/DO27JuAksYnq
 +aH8vI0xGvwn75KqSk4UzAkDzWSmO4ZHuahKtQgZNsMYV+PGayRBX9b9zbldzopoLBdqHc4n
 jQARAQABwsF8BBgBCgAmAhsMFiEEqUDUNJksLo6ZED1QIk+n58yCpmQFAmfIHFQFCRYU6J8A
 CgkQIk+n58yCpmS2PA//bqN1LfcotmArgElsa+0EGZSQlYgK48pm8WAeTXTngudP9IJ4SuKY
 HR5RNjHcBeqN+Me0zxRqYzRb8nGanHEkDyf4Im8DQM8d6vbyU+FcPmG4skud4kgS1zMHnlVd
 SXfSIwKC/hKgdHG8aBV7545Lz9X6Iohea+94wneD0aw/hqF+QWewGZhWJriWAZtvEkzNjQOi
 4U9F/trLten/x7bpphDSnDMKJtITbtzATT1Dq7o7VpIUK1nCTQALMuMjKCdi8OdU/+V+R3O4
 0PXWvX8qrvqYapVbZ+9KqT74FsuB0Ya9uXwgBF2Q6cRuETZk5vqaqKxzqoQZCO8AOz/58j6O
 2RHNy/mZEN+7tJ5Tsq42zVJ4jxsT8b9YplavCMsnBgDeRWhcbYhCyttoL7nYISyWg4kQYZ/P
 wIV3OuNv2f8iKYsxNsRuClOAF82+gvqOy1/1pprFjy8uo2pkoOrb63aOP3vO5VHnRKgra6dq
 NcaZ+c6J4H+nEJGi2SkHAUJz5oBzuThvPudLvPA/SK8sKoM01IRxSihev/S/5WLazXB1PGem
 OCbvzC1IjWJJraxiDJ5IygokapUa2RP7+WBR22skQ3SSl6G107QgWKSyTOGWEaRmV53vxQLV
 jXuCmzSSasTL60zq5yGrT4/DYQVSNEUiUbG4pYekxJujNeEDkUlky0Y=
In-Reply-To: <20260831073619.Ssq-wt7s@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/26 09:36, Sebastian Andrzej Siewior wrote:
> On 2026-08-29 15:49:22 [+0100], Matthew Wilcox wrote:
>> On Sat, Aug 29, 2026 at 10:49:01AM +0200, Peter Zijlstra wrote:
>> > > On PREEMPT_RT, it is necessary to skip the call to
>> > > alloc_pages_nolock_noprof() from under pi_lock, since with that
>> > > configuration spin_trylock can end up needing to take pi_lock. But at
>> > > least on !PREEMPT_RT, there is no risk of deadlock.
>> > 
>> > Yeah, which puts the lie to that horrific hack Alexei did. We should
>> > probably teach lockdep about spin_trylock() not being safe and see the
>> > house of cards crumble.

Is it already happening then?

https://lore.kernel.org/all/20260831053846.107974-1-ngocthang2710.1999@gmail.com/

>> Why is spin_trylock() unsafe on PREEMPT_RT?  It's not intuitive since
>> one can mutex_trylock() in interrupt context or under spinlock.
> 
> no, you shouldn't do mutex_trylock() in IRQ. There was something, I
> don't remember but that is the reason people use semaphores because it
> is okay to do down_trylock() in IRQ. It might be unlock path. 

Is it what this comment (recently moved to can_spin_trylock()) explains?

        /*
         * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which is
         * unsafe in NMI. If spin_trylock() is called from hard IRQ the current
         * task may be waiting for one rt_spin_lock, but rt_spin_trylock() will
         * mark the task as the owner of another rt_spin_lock which will
         * confuse PI logic, so return immediately if called from hard IRQ or
         * NMI.
         *
         * Note, irqs_disabled() case is ok. spin_trylock() can be called
         * from raw_spin_lock_irqsave region.
         */
        if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))           
                return false;

Of course checking for being under raw_spinlock_t can't be added like this,
hm.

> Sebastian

