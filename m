Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E559118FC67
	for <linux-rt-devel@lists.linux.dev>; Fri, 15 Nov 2024 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731709771; cv=none; b=f6tsIqliJyaJ9tcMMpkreVdjpJji3r/Mof0R7BiUumzo3ehBeXlfaL7G8mMDcBCgYavVhyjyY5qSTQuvQeQtCTqck14+wyH7JV6C2LppS5Smpf+1fQBDnh2M7N8oWmFM5kayjlXgxnrjcIW6jF4j8A27rwqYJwceIgIr9PYPJFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731709771; c=relaxed/simple;
	bh=YgvT79iBaGBVWiBS65XCwTu/ttnEG6uZDj9Sw5C75WE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r8vgXkaJUdpsh2mXWWgnflyLBm71LuOB2NsaFuuBVtMDbnrisT5wG5KTgyATts3Am6wxF3SC9i7oh8pp/0+xT+UX0aT/uJRyDyrCQEqh6Nj6tnaVQPX63XAtsZzNDRw/h9vPQXPveDthTaZFxU+GmJ/oOecg9bBsLH3X94zhl/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U3I++ZB0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NevTVyC+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U3I++ZB0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NevTVyC+"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731709766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qfxggv6ATdS6g6AFs0Huv/ja/7B7Fu4yoi78sTHWDUo=;
	b=U3I++ZB0s6lN0p4TkOIgmA1yjiODb5Y9A1GaqCxFsxFW4mqs2HYhzfWKU++XOQkT92j8XL
	vAxQIX80LscbhZvInxbQXzXb+EfeDTx5/9QQC8G1g6baWWxuSN1OL3s2UTzrGe3T+mWTdo
	NiY4VV03eMMl8TCD3JmW+c6fSwT1CEyHQK3jnDrYd8Qjq0TtdYEDwRqXo8M2SOIIITQBtv
	n13c4P511Bh+Wicdb/TZgBMZjdcvT1fcc16oIAdiKzg4Jn9/tmZ3cgwV/lMdlt5uqA7A4a
	aDuBU9ReSaF8cqBdOdOHQDKQKiQGI5vreZ6pTuJZCDTSOEO7U9VDNc1wditIOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731709766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qfxggv6ATdS6g6AFs0Huv/ja/7B7Fu4yoi78sTHWDUo=;
	b=NevTVyC+yzwxBAKjaZgOegdnzziOjLg6+tEWAGDzSXnrWodcqre3bNcInnQ+nHhgzlUOlj
	AT5OXB5dOkQ5caDg==
To: Kunwu Chan <kunwu.chan@linux.dev>, Kunwu Chan <kunwu.chan@linux.dev>,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev,
 syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
Subject: Re: [PATCH] bpf: Convert lpm_trie::lock to 'raw_spinlock_t'
In-Reply-To: <1e5910b1-ea54-4b7a-a68b-a02634a517dd@linux.dev>
References: <20241108063214.578120-1-kunwu.chan@linux.dev>
 <87v7wsmqv4.ffs@tglx> <1e5910b1-ea54-4b7a-a68b-a02634a517dd@linux.dev>
Date: Fri, 15 Nov 2024 23:29:31 +0100
Message-ID: <87sersyvuc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 14 2024 at 10:43, Kunwu Chan wrote:
> On 2024/11/12 23:08, Thomas Gleixner wrote:
>>> @@ -330,7 +330,7 @@ static long trie_update_elem(struct bpf_map *map,
>>>   	if (key->prefixlen > trie->max_prefixlen)
>>>   		return -EINVAL;
>>>   
>>> -	spin_lock_irqsave(&trie->lock, irq_flags);
>>> +	raw_spin_lock_irqsave(&trie->lock, irq_flags);
>>>   
>>>   	/* Allocate and fill a new node */
>> Making this a raw spinlock moves the problem from the BPF trie code into
>> the memory allocator. On RT the memory allocator cannot be invoked under
>> a raw spinlock.
> I'am newbiee in this field. But actually when i change it to a raw 
> spinlock, the problem syzbot reported dispeared.

Yes, because the actual code path which is going to trigger this, is not
reached. But it will be reached at some point.

IIRC, BPF has it's own allocator which can be used everywhere.

Thanks,

        tglx
