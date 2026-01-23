Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC1722156F
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158113; cv=none; b=gSOBw1dVDAioULu2QzKbiMaKWqAS97NzMx7Awcar1wNZcN6/LRlbdA1gBHSstQpV8gTWXlSVaL8WTjvWKZdnSD4hPOQ0x3oxtMgWGGSHtJTr8aQLsT1WLFPIwyUsAF38d46vQ6VwyR2+MdnQ0TwppD1FYrBcoUjEthCTH5D32CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158113; c=relaxed/simple;
	bh=J10ne0a5VTw3TZW1h2qXXjZlUqyCCqcmTQiCQKkeWo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZp+i2IumSGtCh4ADJN2d9NJajHamxz08simRlWvYqNxYhqiSBC4zrE7IM8CBDEPSGS67FpE3yDI/VAh81zjMfgwudBjLF5Lnran74sKQm/DL8VqYwHfr3h+osdaedojAsvIxhzZ2dkofGiPKyZhQyyl8rf6qeYsOurj2xtvhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y36rdCWE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gJBlGkpA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BJOv0lsi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oBputGBP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y36rdCWE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gJBlGkpA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BJOv0lsi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oBputGBP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E416A5BCCE;
	Fri, 23 Jan 2026 08:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769158109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qEh0kdQ3RnJonUDaVBHzBDZl/b1uLfRxPAVFaAKaIaw=;
	b=y36rdCWEuJr4EJKki8VvqeTgiMAfJ6y+Kxs/RYod3kCK61jv8oEnXo1cn60thsZ4HmPm1e
	4lKxMnSmciwYmnGl2Ys1UGIHALxaCd7iwT2TgFpkDpOqEoaXNM7k6/FwzVHnpc1bbKkcgD
	dY4S2NmOO8C1I1K3tAVtQxYa0Mhi6eQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769158109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qEh0kdQ3RnJonUDaVBHzBDZl/b1uLfRxPAVFaAKaIaw=;
	b=gJBlGkpAoZ5wYwOtU9ZtHy4XIYizb0RxMTE2suB/ymtJ9j1FJF0ObTyv1jClxzAqkQaLQ8
	ta7NSVntkVBV3HDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769158108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qEh0kdQ3RnJonUDaVBHzBDZl/b1uLfRxPAVFaAKaIaw=;
	b=BJOv0lsiDqbRa2cFYIYFD8z2hc1yCu7dL10yxEKVRWwjhCmutfWvdEMHwADfIYaJDW4otm
	V0vU7zdkVhcshilGfue+EDs7uFB7ygrr7digQn5wFG+QSEmz6ZWw0lYlieFiQWk7pyR1rY
	sx2Lek6eIBTenSjaKaxvDzX0ig+Z5O8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769158108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qEh0kdQ3RnJonUDaVBHzBDZl/b1uLfRxPAVFaAKaIaw=;
	b=oBputGBPHAFrCsSJRBjyN/X01ve86zrVyuLLyiMiH+woj2antMUUVFZr1sfrwVpxsSk8WD
	pWONmoMvOy67ArDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B80711395E;
	Fri, 23 Jan 2026 08:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pn6ULNw1c2lNUAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Jan 2026 08:48:28 +0000
Message-ID: <763b5f50-2367-4a56-9410-5636458ca2dc@suse.cz>
Date: Fri, 23 Jan 2026 09:48:28 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 04/10] mm/vma: add+use vma lockdep
 acquire/release defines
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <4703b7320796908b9a0827c3d42d74d11b703714.1769086312.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <4703b7320796908b9a0827c3d42d74d11b703714.1769086312.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,google.com,suse.com,linux.dev,kvack.org,vger.kernel.org,lists.linux.dev,infradead.org,redhat.com,gmail.com,linutronix.de,goodmis.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On 1/22/26 14:01, Lorenzo Stoakes wrote:
> The code is littered with inscrutable and duplicative lockdep incantations,
> replace these with defines which explain what is going on and add
> commentary to explain what we're doing.
> 
> If lockdep is disabled these become no-ops. We must use defines so _RET_IP_
> remains meaningful.
> 
> These are self-documenting and aid readability of the code.
> 
> Additionally, instead of using the confusing rwsem_*() form for something
> that is emphatically not an rwsem, we instead explicitly use
> lock_[acquired, release]_shared/exclusive() lockdep invocations since we
> are doing something rather custom here and these make more sense to use.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nits:

> ---
>  include/linux/mmap_lock.h | 35 ++++++++++++++++++++++++++++++++---
>  mm/mmap_lock.c            | 10 +++++-----
>  2 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 0b3614aadbb4..da63b1be6ec0 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -78,6 +78,36 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
> 
>  #ifdef CONFIG_PER_VMA_LOCK
> 
> +/*
> + * VMA locks do not behave like most ordinary locks found in the kernel, so we
> + * cannot quite have full lockdep tracking in the way we would ideally prefer.
> + *
> + * Read locks act as shared locks which exclude an exclusive lock being
> + * taken. We therefore mark these accordingly on read lock acquire/release.
> + *
> + * Write locks are acquired exclusively per-VMA, but released in a shared
> + * fashion, that is upon vma_end_write_all(), we update the mmap's seqcount such
> + * that write lock is de-acquired.

de-acquired -> released?

> + * We therefore cannot track write locks per-VMA, nor do we try. Mitigating this
> + * is the fact that, of course, we do lockdep-track the mmap lock rwsem.

"... which has to be held in order to take a VMA write lock" ?

> + * We do, however, want to indicate that during either acquisition of a VMA
> + * write lock or detachment of a VMA that we require the lock held be exclusive,
> + * so we utilise lockdep to do so.
> + */
> +#define __vma_lockdep_acquire_read(vma) \
> +	lock_acquire_shared(&vma->vmlock_dep_map, 0, 1, NULL, _RET_IP_)
> +#define __vma_lockdep_release_read(vma) \
> +	lock_release(&vma->vmlock_dep_map, _RET_IP_)
> +#define __vma_lockdep_acquire_exclusive(vma) \
> +	lock_acquire_exclusive(&vma->vmlock_dep_map, 0, 0, NULL, _RET_IP_)
> +#define __vma_lockdep_release_exclusive(vma) \
> +	lock_release(&vma->vmlock_dep_map, _RET_IP_)
> +/* Only meaningful if CONFIG_LOCK_STAT is defined. */
> +#define __vma_lockdep_stat_mark_acquired(vma) \
> +	lock_acquired(&vma->vmlock_dep_map, _RET_IP_)
> +
>  static inline void mm_lock_seqcount_init(struct mm_struct *mm)
>  {
>  	seqcount_init(&mm->mm_lock_seq);
> @@ -176,8 +206,7 @@ static inline void vma_refcount_put(struct vm_area_struct *vma)
>  	int refcnt;
>  	bool detached;
> 
> -	rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> -
> +	__vma_lockdep_release_read(vma);
>  	detached = __vma_refcount_put(vma, &refcnt);
>  	/*
>  	 * __vma_enter_locked() may be sleeping waiting for readers to drop
> @@ -203,7 +232,7 @@ static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int
>  							      VM_REFCNT_LIMIT)))
>  		return false;
> 
> -	rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> +	__vma_lockdep_acquire_read(vma);
>  	return true;
>  }
> 
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index ebacb57e5f16..9563bfb051f4 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -72,7 +72,7 @@ static inline int __vma_enter_locked(struct vm_area_struct *vma,
>  	if (!refcount_add_not_zero(VM_REFCNT_EXCLUDE_READERS_FLAG, &vma->vm_refcnt))
>  		return 0;
> 
> -	rwsem_acquire(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
> +	__vma_lockdep_acquire_exclusive(vma);
>  	err = rcuwait_wait_event(&vma->vm_mm->vma_writer_wait,
>  		   refcount_read(&vma->vm_refcnt) == tgt_refcnt,
>  		   state);
> @@ -85,10 +85,10 @@ static inline int __vma_enter_locked(struct vm_area_struct *vma,
>  			WARN_ON_ONCE(!detaching);
>  			err = 0;
>  		}
> -		rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> +		__vma_lockdep_release_exclusive(vma);
>  		return err;
>  	}
> -	lock_acquired(&vma->vmlock_dep_map, _RET_IP_);
> +	__vma_lockdep_stat_mark_acquired(vma);
> 
>  	return 1;
>  }
> @@ -97,7 +97,7 @@ static inline void __vma_exit_locked(struct vm_area_struct *vma, bool *detached)
>  {
>  	*detached = refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLAG,
>  					  &vma->vm_refcnt);
> -	rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> +	__vma_lockdep_release_exclusive(vma);
>  }
> 
>  int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq,
> @@ -199,7 +199,7 @@ static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
>  		goto err;
>  	}
> 
> -	rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> +	__vma_lockdep_acquire_read(vma);
> 
>  	if (unlikely(vma->vm_mm != mm))
>  		goto err_unstable;
> --
> 2.52.0

