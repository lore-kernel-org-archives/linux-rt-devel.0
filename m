Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2555C4EBAE1
	for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186907; cv=none; b=TSsZ1M2ZMtbnpjoHMNEwp5oei9gGzxjJOtf3j05ZRG24UmITZCTQqwKX7RvXvXgqEIntFszzXhJ34+Uv3i1pyFVYYTsb46kXC8/zjWZCdFzphFOvfwQSNNHnZ0njMVu9Iw7pX1RRcSePw8/PcnpAHrjSJPekpoQ4Y8PmNrO1S7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186907; c=relaxed/simple;
	bh=hsHm962YuNOisre/YgDa33CiBqjJ32rHyzOolE3M4yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9e8TEYhc0yeOqNi/hJFY+4eCG9zc1ITXv8u5qFZBHuoSPYibGHypEFyeaTMa1k2xg6rIDArVMXeS2rb+zZAoyl4D/NgPLAvz9OwctnRJchbxBhXnoXkfYbXJvcgTEr4SZM+0bzQ8x+z2zs8kDEI62UmUbM3cfSgPH20uIEFykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FhAo1yGr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=reRENU4a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FhAo1yGr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="reRENU4a"
Date: Mon, 31 Aug 2026 16:35:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788186902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQCpmpjuzvHZKeDSxOgR4WXgjVD/z/uOxa2XNFhQrvs=;
	b=FhAo1yGrj9SphkX9AgYWKr+BHHuPUfBmwP9Dan1NTqSDH/U5fXvsYHSuFynU6gVgg0WIYL
	+ssRsiMlqu3/n5cC4pnURxb71wJ8P7AN8G+aBDEaYMo0NWTzVmYxTSctonb5Qjzc7XVcg/
	otydym7L4ADCgWyhwyT5ExJuHbibM8D5/ER7DdQrDWA3KSdnufKo8SrI94LGhbuwd5qBsS
	/Wsy4GoQZo53SRUvf074yivr9StvQFtRW4uNiFOFByCWW3vA8oTc+pr/cSm+esOW9LttRX
	mrxBiwjrOnYJP+2X2Qbqmc0gtIk8Ahc4lLV6sylGOYb3yJdUtzf78xtoEzyueA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788186902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQCpmpjuzvHZKeDSxOgR4WXgjVD/z/uOxa2XNFhQrvs=;
	b=reRENU4aOqlwB68Wj9QIk77rut8hhjnkPAQX7aFzOZ76ib9xdFd83UL1in678UNrSl3nGF
	7Zf4PHqa+3Kb8lDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: ThangNN99 <ngocthang2710.1999@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	syzbot+acf142088e0182172e58@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] mm/slab: don't use kfree_rcu sheaves on PREEMPT_RT in
 kvfree_call_rcu()
Message-ID: <20260831143500.x-saxdAs@linutronix.de>
References: <20260831130057.HLukQ-zm@linutronix.de>
 <20260831133222.8637-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260831133222.8637-1-ngocthang2710.1999@gmail.com>

On 2026-08-31 20:32:22 [+0700], ThangNN99 wrote:
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -2034,7 +2027,14 @@ void kvfree_call_rcu(struct kvfree_rcu_head *head, void *ptr)
>  	if (!head)
>  		might_sleep();
>  
> -	if (kfree_rcu_sheaf(ptr))
> +	/*
> +	 * Callers may hold a raw_spinlock_t here on PREEMPT_RT (e.g.
> +	 * set_cpus_allowed_force(), whose callers all hold
> +	 * task_struct::pi_lock), and the sheaf/barn locks are also taken
> +	 * as blocking locks elsewhere, so trying them here creates a
> +	 * lockdep-visible ordering conflict. Skip sheaves on PREEMPT_RT.
> +	 */

You mix up things. A raw_spinlock_t should work in general and should
not cause a problem. The task_struct::pi_lock is special: It used during
wakes and the inner waitlock of the rtmutex acquires it even during a
trylock. For PREEMPT_RT we don't want to acquire any locks while the
pi_lock is held.

What about
  
    kvfree_rcu() is called by set_cpus_allowed_force() with
    task_struct::pi_lock acquired. On PREEMPT_RT the local_trylock()
    usage below will acquire the waitlock which must be avoided.
    Therefore avoid it on PREEMPT_RT.

Vlastimil?

> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
>  		return;
>  
>  	// Queue the object but don't yet schedule the batch.

Sebastian
