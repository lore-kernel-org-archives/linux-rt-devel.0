Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C6719F40A
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Jan 2026 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917215; cv=none; b=o7y69QD89CdO9PkXBtpa7oKxSzjBSe7ekv7cPNWgZxBgI37KTkXvASY43kak8Hizce9eRf1Rk4X7yfXUGdEGQmZEQxXMIf6pVFsNlXqsiA/f/mqdiDnjJVkAdmSgABwHBu3g1hcU2xc7Hq+trZXkogiG6iJzwOXxQuJ5hN3ac1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917215; c=relaxed/simple;
	bh=5qbZ+e7RnacX80skCV78gPsXIbFAtQLwvMWdf9WuSt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=muy5QbCsMmOXwvoubm7ikqqhpESVJagv0MenX2F5BzIgBPXQodVyWD+Bk28T6Hjk0ZGvPO3jkzajlSodRSMUYtEefXT+pvAtBXw5uvUrrAxgsQir2v5g9rNOzhjdA6SzUuBpapz/CD9bkjIGHwexLblZzVez3b6ztcBNmy09LcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZexLY8tP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rmvli727; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZexLY8tP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rmvli727; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZexLY8tP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rmvli727";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZexLY8tP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rmvli727"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F2DC65BCCC;
	Tue, 20 Jan 2026 13:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768917211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KqKkMtS0KU8ZcdmqP+5+V86Ckg0CaMGNunHU579OoB4=;
	b=ZexLY8tP0oXVpVFwefK4bjndfkLTr8kNDrkaT62Oek03uJ4HuYlfujKeVdE8Cg2U5N0BV5
	aPcBBSi56BWVqaGNzn1JgnugsKX+dTrSJh98j7o2WyRC2AA+uPgCPb/cqpquFga4WNyed8
	TjuetzW6vVKEKaMwFkfayWw0DN6zjxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768917211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KqKkMtS0KU8ZcdmqP+5+V86Ckg0CaMGNunHU579OoB4=;
	b=Rmvli727iuePClT02xFlOmBB2r8dDmP3wr/tOJLzd5NfUHmYrlsSDSkUpWJRHzTeSYP/bI
	jYn0RIXnAip3KZBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768917211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KqKkMtS0KU8ZcdmqP+5+V86Ckg0CaMGNunHU579OoB4=;
	b=ZexLY8tP0oXVpVFwefK4bjndfkLTr8kNDrkaT62Oek03uJ4HuYlfujKeVdE8Cg2U5N0BV5
	aPcBBSi56BWVqaGNzn1JgnugsKX+dTrSJh98j7o2WyRC2AA+uPgCPb/cqpquFga4WNyed8
	TjuetzW6vVKEKaMwFkfayWw0DN6zjxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768917211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KqKkMtS0KU8ZcdmqP+5+V86Ckg0CaMGNunHU579OoB4=;
	b=Rmvli727iuePClT02xFlOmBB2r8dDmP3wr/tOJLzd5NfUHmYrlsSDSkUpWJRHzTeSYP/bI
	jYn0RIXnAip3KZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBAC13EA63;
	Tue, 20 Jan 2026 13:53:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iGHtL9qIb2kHPAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 20 Jan 2026 13:53:30 +0000
Message-ID: <30f843d9-03cf-4c7c-8a29-8e11b12e47e4@suse.cz>
Date: Tue, 20 Jan 2026 14:53:30 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/vma: use lockdep where we can, reduce
 duplication
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
References: <cover.1768855783.git.lorenzo.stoakes@oracle.com>
 <bd410fd91d22eef37f9b617327cafce33b267b09.1768855783.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <bd410fd91d22eef37f9b617327cafce33b267b09.1768855783.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

On 1/19/26 21:59, Lorenzo Stoakes wrote:
> We introduce vma_is_read_locked(), which must deal with the case in which
> VMA write lock sets refcnt to VMA_LOCK_OFFSET or VMA_LOCK_OFFSET +
> 1. Luckily is_vma_writer_only() already exists which we can use to check
> this.

So I think there's a bit of a caveat in that

- is_vma_writer_only() may be a false positive if there is a temporary
reader of a detached vma (per comments in vma_mark_detached() and
vma_mark_detached())

- hence vma_is_read_locked() may be a false negative

- hence vma_assert_locked() might assume wrongly that we should not assert
being a reader, so we vma_assert_write_locked() instead, and fail

Howevever the above should mean it could be only us who is the temporary
reader. And we are not going to use vma_assert_locked() during the temporary
reader part (in vma_start_read()).

So it's probably fine, but maybe worth some comments to prevent people
getting suspicious and reconstructing this?

But I think perhaps also vma_assert_locked() could, with lockdep enabled
(similarly to vma_assert_stabilised() in patch 2), use the
"lock_is_held(&vma->vmlock_dep_map)" condition (without immediately
asserting it) for the primary reader vs writer decision, and not rely on
vma_is_read_locked()? Because lockdep has the precise information.

It would likely make things more ugly, or require more refactoring, but
hopefully worthwhile?

> We then try to make vma_assert_locked() use lockdep as far as we can.
> 
> Unfortunately the VMA lock implementation does not even try to track VMA
> write locks using lockdep, so we cannot track the lock this way.
> 
> This is less egregious than it might seem as VMA write locks are predicated
> on mmap write locks, which we do lockdep assert.
> 
> vma_assert_write_locked() already asserts the mmap write lock is taken so
> we get that checked implicitly.

> However for read locks we do indeed use lockdup, via rwsem_acquire_read()
> called in vma_start_read() and rwsem_release_read() called in
> vma_refcount_put() called in turn by vma_end_read().
> 
> Therefore we perform a lockdep assertion if the VMA is known to be
> read-locked.
> 
> If it is write-locked, we assert the mmap lock instead, with a lockdep
> check if lockdep is enabled.
> 
> If lockdep is not enabled, we just check that locks are in place.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/mmap_lock.h | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index b50416fbba20..6979222882f1 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -236,6 +236,13 @@ int vma_start_write_killable(struct vm_area_struct *vma)
>  	return __vma_start_write(vma, mm_lock_seq, TASK_KILLABLE);
>  }
>  
> +static inline bool vma_is_read_locked(const struct vm_area_struct *vma)
> +{
> +	const unsigned int refcnt = refcount_read(&vma->vm_refcnt);
> +
> +	return refcnt > 1 && !is_vma_writer_only(refcnt);
> +}
> +
>  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
>  {
>  	unsigned int mm_lock_seq;
> @@ -243,12 +250,31 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
>  	VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
>  }
>  
> +/**
> + * vma_assert_locked() - Assert that @vma is either read or write locked and
> + * that we have ownership of that lock (if lockdep is enabled).
> + * @vma: The VMA we assert.
> + *
> + * If lockdep is enabled, we ensure ownership of the VMA lock. Otherwise we
> + * assert that we are VMA write-locked, which implicitly asserts that we hold
> + * the mmap write lock.
> + */
>  static inline void vma_assert_locked(struct vm_area_struct *vma)
>  {
> -	unsigned int mm_lock_seq;
> -
> -	VM_BUG_ON_VMA(refcount_read(&vma->vm_refcnt) <= 1 &&
> -		      !__is_vma_write_locked(vma, &mm_lock_seq), vma);
> +	/*
> +	 * VMA locks currently only utilise lockdep for read locks, as
> +	 * vma_end_write_all() releases an unknown number of VMA write locks and
> +	 * we don't currently walk the maple tree to identify which locks are
> +	 * released even under CONFIG_LOCKDEP.
> +	 *
> +	 * However, VMA write locks are predicated on an mmap write lock, which
> +	 * we DO track under lockdep, and which vma_assert_write_locked()
> +	 * asserts.
> +	 */
> +	if (vma_is_read_locked(vma))
> +		lockdep_assert(lock_is_held(&vma->vmlock_dep_map));
> +	else
> +		vma_assert_write_locked(vma);
>  }
>  
>  static inline bool vma_is_attached(struct vm_area_struct *vma)

