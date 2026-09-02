Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B247F2D9;
	Wed,  2 Sep 2026 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358417; cv=none; b=e8hRoRgTosKoHpHKmzuo6e8LAocb+Zy/Sw4NmZ1lDjmb9a104mPn7WeQExf4r7foZNuABxGytA5QlCGDPAFbs/RgHdBykNZBNRAKSKm9aCD/IjSkSaLIEutKRGyMzlnIpHaqmPt33jg9lSpIacbqEZjgdDpAiilM4ALqcf3dmgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358417; c=relaxed/simple;
	bh=9zHpapmxC+Vh64gr1kcWeAiToxLV0h2o3P3zRooS57c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ki2IdsL6sJCHzmjmXVcChUsA0FKXG34Xa/1jUiRpm17jGNG5N7qKbT/UrCB1tZaz+ccZp0BSA/buyYgmbTKqoaWI/I/XOHBNfPauyfCNat1hsfCyxk5Pv1dcdnK8NIyfYJSI+CJxV7o3txwqul4yY3aPUNF+vF9MJudSk5BKDlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZnwviuK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZnwviuK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9971E1F00A3D;
	Wed,  2 Sep 2026 14:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788358415;
	bh=NLEoYxETqRPjTXxDSlNfnFbEqTN4nnEwi7Vb6jwx3Qk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QZnwviuKDFKR+6/XzTVwVwWCb9WHHT2ShCVLa52wUcK/DbFoGo9q/O7t7HnF63hAx
	 YuF8M6NhIZmrKZUpeVjBCC42nT54TDSsMXnu3hIutrod+l7hyZfmAdDksuqDnmMXK7
	 UAj2NMR6ZItAWeoByNYlLPEhmPl2yRqvPfRlZMh+EzZGVgs/U4a4mHmxgjURLtj/p+
	 6TaqTzY889EBzEEXfIQFzF2hp5ekOEXuIMa+EuLSWN+eISSzpY+qoR6NJzl19tIOWR
	 2nWHUJbDEMUb8lrUf8/AFQvsSF5faG78/4PJH0L8E71az8tQ2eXJGkjw+x3NX06NR4
	 inVsrFobqC4zg==
Message-ID: <1846af86-cf55-456d-9eca-975a88777a40@kernel.org>
Date: Wed, 2 Sep 2026 16:13:30 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: disallow kfree_rcu_sheaf() on PREEMPT_RT again
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Harry Yoo <harry@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 syzbot+acf142088e0182172e58@syzkaller.appspotmail.com,
 ThangNN99 <ngocthang2710.1999@gmail.com>
References: <20260831-b4-kfree_rcu_hotfix-v1-1-4f0fb882638b@kernel.org>
 <20260901073339.uyKHXWCX@linutronix.de>
 <47aa459f-27d5-4b2f-9eb9-36ebca63d890@kernel.org>
 <20260902104143.j8BXrjKq@linutronix.de>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260902104143.j8BXrjKq@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/2/26 12:41, Sebastian Andrzej Siewior wrote:
> On 2026-09-01 15:59:09 [+0200], Vlastimil Babka (SUSE) wrote:
>> On 9/1/26 09:33, Sebastian Andrzej Siewior wrote:
>> > On 2026-08-31 18:02:38 [+0200], Vlastimil Babka (SUSE) wrote:
>> >> This partially reverts commit 2a8bb29ec9b2 ("mm/slab: allow
>> >> kfree_rcu_sheaf() on PREEMPT_RT"). It was based on an assumption that
>> >> local_trylock() is safe on PREEMPT_RT from any context.
>> > …
>> >> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> > 
>> >> ---
>> >> Incidentally I have posted a RFC [1] that leads to replacing that
>> >> kfree_rcu() from set_cpus_allowed_force() but now after back from
>> >> vacation I need to check the feedback and based on this bug report I can
>> >> already see it makes the same bad assumption that trylock is fine.
>> > 
>> > free_to_pcs() has still this trylock.
>> > 
>> > What I am not so sure how good is that kfree_rcu_nolock() may allocate
>> > memory for the sheaf if there is none around.
>> 
>> Per sashiko review it's actually bad too under the pi_lock, because
>> GFP_NOWAIT means __GFP_KSWAPD_RECLAIM which can mean wakeup_kswapd() and
>> thus also need scheduler locks. And it's not a PREEMPT_RT-only issue...
> 
> \o/

More like /o\

>> > It could have a pool of X
>> > and if it runs out, it runs out and waits until the clean up process
>> > feeds the used sheafs back. There is fallback and the run out is not the
>> > usual case.
>> 
>> I'd rather not invent new pools, since there's fallback and the sheaf+barn
>> is already a pool. Could be enough to make sure the allocation attempt is
>> safe, i.e. use only __GFP_NOWARN.
> 
> So we avoid the allocation and just add it to the sheaf+barn and this is
> it?

We don't need to avoid the allocation attempt if it's done in a safe way?
Note the new sheaf can be also served from its kmalloc slab almost
immediately, going all the way to page allocator should be very rare.
But if we stopped doing that sheaf allocation attemps completely, we could
easily end up having long bursts of all kfree_rcu() being deferred.

> Sebastian

