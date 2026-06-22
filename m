Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A1F39AD34
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782130410; cv=none; b=bnqynRWfiNF2fkViMKNbfnm16XP1MWVDb9yi9A3o8b89PvbWQpvMj+pqI9ibtQ3cQLggRuxCBBXm77RA1x308aZz5Xr0Pb4Ta48scMv6saZqW5MJY5QIykaM4xFOfR+1Ys7fuqRK/Y39ExY2vjbzGaJSKi6JNO8nhrcH0UXyb54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782130410; c=relaxed/simple;
	bh=eDhXiCy4m8TmjQaqRl5eJVxnFiiabYVrNq90oq2akAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaQa6Q9FlXrPYXi/KoE+ZpwA0mO9d1WlFk6jPlpLpG2OSD3s5joouUFs34PoTshB7HqJBL4MwsxHHaMO9KcocxH0zBTEcYpLY55MZXApvZX+UxL5gNr17jyErSBKvzlzC3soqkH99JfRaID9CO9bpkrgWyWk/OBmJ1+wunaY53c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kxN0BjWd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O6wHtqOA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xNpnN7FA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pxD8rKv6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kxN0BjWd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O6wHtqOA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xNpnN7FA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pxD8rKv6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1AA770682;
	Mon, 22 Jun 2026 12:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782130407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FywxqINqQ4eDy+hspQ+TMrspJCk9I8ZmH/KABcirIBo=;
	b=kxN0BjWd11SNbdGOC0i9gQxSYMXkj39t17vFXawSk1bH1zxLkp+S7fQWJsjIvnvHg2WYx0
	ij/tNRvj5LA1K2hiT2tZMJpuNk3JLYOx2fCcRZB/1e9zPRxlbgJ+I75p5IO0k9VxWX/szF
	7SFppgyripWFPiZiw2wVfofCbyTJ7XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782130407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FywxqINqQ4eDy+hspQ+TMrspJCk9I8ZmH/KABcirIBo=;
	b=O6wHtqOA96qLNL+sdOhh+sm0KlFdxhOr+QlwYCRIVdcsAIpeSd6ezdakKIVRH9VzT1+0vg
	YbVHUNDwMOFoqsAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782130405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FywxqINqQ4eDy+hspQ+TMrspJCk9I8ZmH/KABcirIBo=;
	b=xNpnN7FAv5KKAuRE1uBrxSjbX430sS8edi1xMJHIMxB0KuyA4bgIdVjRM7rGmWfSfLOwuO
	OQNrQSH2EmoE20/KzzbOv39Qk5DNN7F9AULR1tH+4sURNOuHYZgkW0yg/VNNVqzDo3MABw
	wUVUStVp2g+aV/mZC5vdubsJlfEuWNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782130405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FywxqINqQ4eDy+hspQ+TMrspJCk9I8ZmH/KABcirIBo=;
	b=pxD8rKv6U3KmTOaENuCKgzr7/Id8CI+j9X8y6xyu7OyVbfgZTkiV9pO8bTBGydGttbYcPY
	RfuymKU9KmxRHhBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 967FE779A8;
	Mon, 22 Jun 2026 12:13:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h9+2JOUmOWr7WAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jun 2026 12:13:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3BC95A12DE; Mon, 22 Jun 2026 14:13:25 +0200 (CEST)
Date: Mon, 22 Jun 2026 14:13:25 +0200
From: Jan Kara <jack@suse.cz>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: jack@suse.com, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	rostedt@goodmis.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	syzbot+6a680377e13041c19d50@syzkaller.appspotmail.com
Subject: Re: [PATCH] udf: avoid recursive s_alloc_mutex deadlock when freeing
 AED blocks
Message-ID: <4r6lyehf3xjx3evthhnklrvaejwz2wm5p7vmk6h42hhyrjsia6@kdpg7pfwnrjm>
References: <20260621035841.56194-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621035841.56194-1-kartikey406@gmail.com>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[6a680377e13041c19d50];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oepos.bh:url,suse.com:email,syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:helo,epos.bh:url,goal_epos.bh:url,appspotmail.com:email]
X-Spam-Level: 
X-Spam-Score: -2.30

On Sun 21-06-26 09:28:41, Deepanshu Kartikey wrote:
> udf_table_prealloc_blocks() and udf_table_new_block() call
> udf_delete_aext() on the unallocated-space-table inode while holding
> sbi->s_alloc_mutex. When the deleted allocation descriptor empties an
> allocation-extent (AED) block, udf_delete_aext() returns that block to
> free space via udf_free_blocks(). For a table-managed partition that
> path is udf_free_blocks() -> udf_table_free_blocks() ->
> mutex_lock(&sbi->s_alloc_mutex), i.e. the task tries to acquire a mutex
> it already holds.
> 
> On a PREEMPT_RT kernel the rtmutex deadlock detector reports this as
> -EDEADLK:
> 
>   rtmutex deadlock detected
>   WARNING: kernel/locking/rtmutex.c:1698 at rt_mutex_handle_deadlock
>   udf_table_free_blocks fs/udf/balloc.c:376 [inline]
>   udf_free_blocks+0xa8c/0x1900 fs/udf/balloc.c:678
>   udf_delete_aext+0x4f5/0xc00 fs/udf/inode.c:2381
>   udf_table_prealloc_blocks fs/udf/balloc.c:544 [inline]
>   udf_prealloc_blocks+0xbd4/0x10e0 fs/udf/balloc.c:702
> 
> On a non-RT kernel the same path is a hard self-deadlock (or a lockdep
> recursive-locking splat). It is reachable from a crafted UDF image via
> the write/sendfile path.
> 
> The allocator already refuses to recurse on the add side: see the
> comment in udf_table_free_blocks() explaining why it must not call
> udf_add_aext() while holding s_alloc_mutex. Apply the same rule to the
> delete side. Let udf_delete_aext() report the AED block it would
> otherwise free through a new out-parameter, and have the two callers
> that hold s_alloc_mutex free it after dropping the lock. The block is
> already unlinked from the inode's descriptor chain by then, so nothing
> can reference it in the meantime. All other callers pass NULL and keep
> freeing the block inline, exactly as before.
> 
> The out-parameter is pre-initialised with the reserved partition number
> 0xFFFF, which can never name a real block, so the caller can tell
> whether a block was handed back.
> 
> Reported-by: syzbot+6a680377e13041c19d50@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6a680377e13041c19d50
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  fs/udf/balloc.c   | 12 ++++++++++--
>  fs/udf/inode.c    | 19 ++++++++++++++++---
>  fs/udf/truncate.c |  2 +-
>  fs/udf/udfdecl.h  |  3 ++-
>  4 files changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
> index cc6dc6e1d84d..30cec5600149 100644
> --- a/fs/udf/balloc.c
> +++ b/fs/udf/balloc.c
> @@ -502,6 +502,8 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
>  	int8_t etype = -1;
>  	struct udf_inode_info *iinfo;
>  	int ret = 0;
> +	/* AED block freed by udf_delete_aext(), released after unlock */
> +	struct kernel_lb_addr freed = { .partitionReferenceNum = 0xFFFF };
>  
>  	if (first_block >= sbi->s_partmaps[partition].s_partition_len)
>  		return 0;
> @@ -541,7 +543,7 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
>  			udf_write_aext(table, &epos, &eloc,
>  					(etype << 30) | elen, 1);
>  		} else
> -			udf_delete_aext(table, epos);
> +			udf_delete_aext(table, epos, &freed);
>  	} else {
>  		alloc_count = 0;
>  	}
> @@ -552,6 +554,8 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
>  	if (alloc_count)
>  		udf_add_free_space(sb, partition, -alloc_count);
>  	mutex_unlock(&sbi->s_alloc_mutex);
> +	if (freed.partitionReferenceNum != 0xFFFF)
> +		udf_free_blocks(sb, table, &freed, 0, 1);
>  	return alloc_count;
>  }
>  
> @@ -560,6 +564,8 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
>  			       uint32_t goal, int *err)
>  {
>  	struct udf_sb_info *sbi = UDF_SB(sb);
> +	/* AED block freed by udf_delete_aext(), released after unlock */
> +	struct kernel_lb_addr freed = { .partitionReferenceNum = 0xFFFF };
>  	uint32_t spread = 0xFFFFFFFF, nspread = 0xFFFFFFFF;
>  	udf_pblk_t newblock = 0;
>  	uint32_t adsize;
> @@ -643,12 +649,14 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
>  	if (goal_elen)
>  		udf_write_aext(table, &goal_epos, &goal_eloc, goal_elen, 1);
>  	else
> -		udf_delete_aext(table, goal_epos);
> +		udf_delete_aext(table, goal_epos, &freed);
>  	brelse(goal_epos.bh);
>  
>  	udf_add_free_space(sb, partition, -1);
>  
>  	mutex_unlock(&sbi->s_alloc_mutex);
> +	if (freed.partitionReferenceNum != 0xFFFF)
> +		udf_free_blocks(sb, table, &freed, 0, 1);
>  	*err = 0;
>  	return newblock;
>  }
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 67bcf83758c8..ebb67ce0aed7 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -1204,7 +1204,7 @@ static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
>  
>  	if (startnum > endnum) {
>  		for (i = 0; i < (startnum - endnum); i++)
> -			udf_delete_aext(inode, *epos);
> +			udf_delete_aext(inode, *epos, NULL);
>  	} else if (startnum < endnum) {
>  		for (i = 0; i < (endnum - startnum); i++) {
>  			err = udf_insert_aext(inode, *epos,
> @@ -2328,7 +2328,8 @@ static int udf_insert_aext(struct inode *inode, struct extent_position epos,
>  	return ret;
>  }
>  
> -int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
> +int8_t udf_delete_aext(struct inode *inode, struct extent_position epos,
> +			struct kernel_lb_addr *freed)
>  {
>  	struct extent_position oepos;
>  	int adsize;
> @@ -2378,7 +2379,19 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
>  	elen = 0;
>  
>  	if (epos.bh != oepos.bh) {
> -		udf_free_blocks(inode->i_sb, inode, &epos.block, 0, 1);
> +		/*
> +		 * The block that held the now-empty allocation extent must be
> +		 * returned to free space.  When the caller already holds
> +		 * s_alloc_mutex (the space-table allocator in balloc.c),
> +		 * freeing it inline would recurse through udf_free_blocks()
> +		 * into udf_table_free_blocks() and deadlock re-acquiring
> +		 * s_alloc_mutex.  In that case report the block to the caller,
> +		 *  which frees it after dropping the lock.
> +		 */
> +		if (freed)
> +			*freed = epos.block;
> +		else
> +			udf_free_blocks(inode->i_sb, inode, &epos.block, 0, 1);
>  		udf_write_aext(inode, &oepos, &eloc, elen, 1);
>  		udf_write_aext(inode, &oepos, &eloc, elen, 1);
>  		if (!oepos.bh) {
> diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
> index 41b2bfd30449..0990f94b8551 100644
> --- a/fs/udf/truncate.c
> +++ b/fs/udf/truncate.c
> @@ -159,7 +159,7 @@ void udf_discard_prealloc(struct inode *inode)
>  
>  	if (etype == (EXT_NOT_RECORDED_ALLOCATED >> 30)) {
>  		lbcount -= elen;
> -		udf_delete_aext(inode, prev_epos);
> +		udf_delete_aext(inode, prev_epos, NULL);
>  		udf_free_blocks(inode->i_sb, inode, &eloc, 0,
>  				DIV_ROUND_UP(elen, bsize));
>  	}
> diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
> index 6d951e05c004..01e4ce8644a9 100644
> --- a/fs/udf/udfdecl.h
> +++ b/fs/udf/udfdecl.h
> @@ -170,7 +170,8 @@ extern int udf_add_aext(struct inode *, struct extent_position *,
>  			struct kernel_lb_addr *, uint32_t, int);
>  extern void udf_write_aext(struct inode *, struct extent_position *,
>  			   struct kernel_lb_addr *, uint32_t, int);
> -extern int8_t udf_delete_aext(struct inode *, struct extent_position);
> +extern int8_t udf_delete_aext(struct inode *, struct extent_position,
> +			       struct kernel_lb_addr *);
>  extern int udf_next_aext(struct inode *inode, struct extent_position *epos,
>  			 struct kernel_lb_addr *eloc, uint32_t *elen,
>  			 int8_t *etype, int inc);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
