Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792638782;
	b=QwzVNZqtFLFu0TWhS32wcVBrsXTILVOHtNuUr0yxWN1/h8Fa2c4u1Dxj+y0WlYi5rUt+
	 37jzebrf5lvM6Veg5bqupXa5LyMEScOaTfErG77C7mqh0ymMN5l8oc8OnKsdhs8+rUdwB
	 KBdR975FcmbhNL4ZeEXEybrGd6AS59+g+5bLc/eElwDeBAY6ve9Z7pqeNHD/zZgvvsoGH
	 nBxYWSVeELGzoGcGBASjzz03aZRKC4ZIA/8qXkJXhCsOds9Dfum4OQvHPOpYknAN8C1Mg
	 4DNPNUv12qRMy4zsotidlNoQNBTDHuqdngAllIxkFszwJHP7hD1rZnH8wdL9JVoYg2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792638782;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JkXp0k1p7Z2vzdKhwQLlNSEM3rV4rY1tJD5BRvLgl0I=;
	b=brTA9Y31jQWmkeF+HE5ZODyrVLiZiSj8JQOpwcMCLicpnQMPLHLE/4MNoYGgcDfv832p
	 4/Sq3MQVHXBuW3d0m43DC1iGQILaPVcFpajESvodpxeyKOGuzvh7bLhjhBLsEsBUauFDx
	 i5ft2EkgIxCbLo4S1azZrLlG3nbiX1FIvLT7u+bYXmku9LY3bbJvIHm96NEmEkvH4IzLD
	 67O7Iz4DOcoMl5wNlbxJJXGUZYQakyoa75NPYmbx5NAglZelDgutiUps5xxnC/qlK+WBp
	 BSR55AkjqpP5GGRPf719HC/C8s4wzy43VlnKR423rG9ywexXzufG4SwAqMBLvWw4cpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m31Tdr4Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DAF606A31A;
	Thu, 22 Oct 2026 03:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m31Tdr4Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EA91F000C1;
	Thu, 22 Oct 2026 03:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792638781;
	bh=JkXp0k1p7Z2vzdKhwQLlNSEM3rV4rY1tJD5BRvLgl0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m31Tdr4QzcDD+Upv6cCXgl4TaS+DLwnezLcHKnV7dphWNCFsa377WSQaw1qO3lA5h
	 EDfDpuchGnpLjHy7WPO8ldiA1uF2DBld1Caf0njsuxA/38N8l0pd9yZqlASpbMi1XU
	 q9yRxkQA8SoigytduEPAT8YzBkysTPR6hMveUR7MEqCFHdLg9frIX8TnRjUVjktWoP
	 aKlVJsPCKBagOJls34BA42KZkyvkat00BhXfoH3fgDQv5q+AxZ1mqUlMgwwXknfU1A
	 sr6tD2EsTo1X7T4AZSlXoBlvX/cDj/XTLLH+0nwXVVnNt2QwOXJiKrYMszp4JexcWv
	 4UL16wS2MoWZw==
Message-ID: <sashiko-outbox-180899@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] io_uring/futex: add persistent waits and
 registered wakes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Austin Schuh" <austin.linux@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261022024701.1574811-3-austin.linux@gmail.com>
References: <20261022024701.1574811-1-austin.linux@gmail.com>
 <20261022024701.1574811-3-austin.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 03:13:00 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] io_uring/futex: NULL deref in io_futex_node_get() on !CONFIG_MMU
- [High] io_uring/futex: busy-spin on teardown from uncleared futex_pending
- [Medium] io_uring/futex: 32-bit truncation of SQE fields in io_futex_prep=
()
--

commit d39ae03333a1ccb677abc6626226b97d34d99fdf
Author: Austin Schuh <austin.linux@gmail.com>

io_uring/futex: add persistent waits and registered wakes

This commit adds persistent futex waits and registered futex wakes to
io_uring to avoid futex hash bucket lock contention on PREEMPT_RT. It
introduces registration opcodes for futex words and uses an RCU-walked node
table and per-ring pending bitmaps to notify waiting rings without taking
sleeping locks in the wake path.

> diff --git a/io_uring/futex.c b/io_uring/futex.c
> index 9203998654ffb..9f5050bfd3d44 100644
> --- a/io_uring/futex.c
> +++ b/io_uring/futex.c

[ ... ]

> +/*
> + * A key without FUT_OFF_INODE names its mm by pointer.  The node keeps =
the
> + * mm_struct allocated so the pointer can't be reused for another mm whi=
le
> + * the node can still be found by it.
> + */
> +static bool io_futex_key_has_mm(union futex_key *key)
> +{
> +	return !(key->both.offset & FUT_OFF_INODE);
> +}
> +
> +static struct io_futex_node *io_futex_node_get(u32 __user *uaddr,
> +					       unsigned int flags)
> +{
> +	union futex_key key =3D FUTEX_KEY_INIT;
> +	struct io_futex_node *node, *new =3D NULL;
> +	struct io_futex_bucket *b;
> +	int ret;
> +
> +	/* Write access, as a waker needs: reading the word is not enough. */
> +	ret =3D get_futex_key(uaddr, flags, &key, FUTEX_WRITE);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	b =3D io_futex_bucket(&key);
> +again:
> +	spin_lock(&b->lock);
> +	hlist_for_each_entry(node, &b->nodes, hnode) {
> +		if (futex_match(&node->key, &key)) {
> +			/* A node at zero has already left the bucket. */
> +			refcount_inc(&node->ref);
> +			spin_unlock(&b->lock);
> +			kfree(new);
> +			return node;
> +		}
> +	}
> +	if (!new) {
> +		/* Allocate only on a miss, and not under the lock. */
> +		spin_unlock(&b->lock);
> +		new =3D kzalloc_obj(*new, GFP_KERNEL_ACCOUNT);
> +		if (!new)
> +			return ERR_PTR(-ENOMEM);
> +		goto again;
> +	}
> +	new->key =3D key;
> +	new->bucket =3D b;
> +	INIT_HLIST_HEAD(&new->members);
> +	refcount_set(&new->ref, 1);
> +	if (io_futex_key_has_mm(&key))
> +		mmgrab(key.private.mm);
> +	hlist_add_head(&new->hnode, &b->nodes);
> +	spin_unlock(&b->lock);
> +	return new;
> +}
> +
> +static void io_futex_node_put(struct io_futex_node *node)
> +{
> +	if (!refcount_dec_and_lock(&node->ref, &node->bucket->lock))
> +		return;
> +	hlist_del(&node->hnode);
> +	spin_unlock(&node->bucket->lock);
> +	if (io_futex_key_has_mm(&node->key))
> +		mmdrop(node->key.private.mm);

[Severity: High]
Can this trigger a NULL pointer dereference in io_futex_node_get() and
io_futex_node_put() on !CONFIG_MMU kernels?

On !CONFIG_MMU builds, FLAGS_SHARED is defined as 0x0000 in
kernel/futex/futex.h, so get_futex_key() in kernel/futex/core.c always takes
the !fshared path, leaves FUT_OFF_INODE unset in key->both.offset, and sets
key->private.mm to NULL:

kernel/futex/core.c:get_futex_key() {
	if (!fshared) {
		if (IS_ENABLED(CONFIG_MMU))
			key->private.mm =3D mm;
		else
			key->private.mm =3D NULL;

		key->private.address =3D address;
		return 0;
	}
}

Because io_futex_key_has_mm() only checks !(key->both.offset & FUT_OFF_INOD=
E),
it returns true when CONFIG_MMU is disabled, causing io_futex_node_get() to
call mmgrab(NULL) and io_futex_node_put() to call mmdrop(NULL). Should
io_futex_key_has_mm() also check key->private.mm !=3D NULL (or
IS_ENABLED(CONFIG_MMU))?

> +	/* A registered wake may still be walking it. */
> +	kfree_rcu(node, rcu);
> +}

[ ... ]

> @@ -127,23 +847,69 @@ bool io_futex_remove_all(struct io_ring_ctx *ctx, s=
truct io_uring_task *tctx,
>  int io_futex_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  {
>  	struct io_futex *iof =3D io_kiocb_to_cmd(req, struct io_futex);
> -	u32 flags;
> +	u32 flags, uflags;
> =20
> -	if (unlikely(sqe->len || sqe->futex_flags || sqe->buf_index ||
> -		     sqe->file_index))
> +	if (unlikely(sqe->len))
>  		return -EINVAL;
> =20
> +	uflags =3D READ_ONCE(sqe->futex_flags);
> +	iof->iou_flags =3D uflags;
> +	iof->member =3D NULL;
>  	iof->uaddr =3D u64_to_user_ptr(READ_ONCE(sqe->addr));
>  	iof->futex_val =3D READ_ONCE(sqe->addr2);
>  	iof->futex_mask =3D READ_ONCE(sqe->addr3);
>  	flags =3D READ_ONCE(sqe->fd);
> =20
> +	if (req->opcode =3D=3D IORING_OP_FUTEX_WAIT) {
> +		if (uflags & ~(IORING_FUTEX_PERSISTENT | IORING_FUTEX_REARM) ||
> +		    uflags =3D=3D (IORING_FUTEX_PERSISTENT | IORING_FUTEX_REARM) ||
> +		    sqe->buf_index)
> +			return -EINVAL;
> +		/*
> +		 * A persistent wait's slot, as a direct descriptor's: index + 1,
> +		 * or IORING_FILE_INDEX_ALLOC.  A re-arm names the slot the same
> +		 * way, as a close does.
> +		 */
> +		iof->futex_nr =3D READ_ONCE(sqe->file_index);
> +		if (!(uflags & (IORING_FUTEX_PERSISTENT | IORING_FUTEX_REARM)) !=3D
> +		    !iof->futex_nr)
> +			return -EINVAL;
> +		if (uflags & IORING_FUTEX_REARM) {
> +			if (iof->uaddr || iof->futex_val || iof->futex_mask ||
> +			    flags || iof->futex_nr =3D=3D IORING_FILE_INDEX_ALLOC)
> +				return -EINVAL;
> +			iof->futex_nr--;
> +			return 0;
> +		}
> +	} else if (sqe->file_index) {
> +		return -EINVAL;
> +	} else if (uflags) {
> +		/* Woken by slot: no word, no count, only the bitset. */
> +		if (uflags !=3D IORING_FUTEX_REGISTERED || iof->uaddr ||
> +		    iof->futex_val || flags || !iof->futex_mask ||
> +		    iof->futex_mask > U32_MAX)
> +			return -EINVAL;

[Severity: Medium]
On 32-bit architectures, struct io_futex defines uaddr as void __user * and
futex_val and futex_mask as unsigned long:

struct io_futex {
	struct file	*file;
	void __user	*uaddr;
	unsigned long	futex_val;
	unsigned long	futex_mask;
	...
};

When io_futex_prep() reads the 64-bit sqe->addr, sqe->addr2, and sqe->addr3
fields into iof->uaddr, iof->futex_val, and iof->futex_mask, doesn't that
truncate the upper 32 bits on 32-bit kernels before the validation checks
run?

In addition, on 32-bit architectures where unsigned long is 32 bits wide,
won't the check iof->futex_mask > U32_MAX in io_futex_prep() always be false
and trigger a compiler tautological-compare warning while failing to reject
non-zero upper 32 bits in sqe->addr3?

[ ... ]

> diff --git a/io_uring/tw.h b/io_uring/tw.h
> index 3ade5ad577fda..dc9125ebdd829 100644
> --- a/io_uring/tw.h
> +++ b/io_uring/tw.h

[ ... ]

> @@ -90,7 +91,8 @@ static inline int io_run_task_work(void)
> =20
>  static inline bool io_local_work_pending(struct io_ring_ctx *ctx)
>  {
> -	return !mpscq_empty(&ctx->work_list);
> +	return !mpscq_empty(&ctx->work_list) ||
> +	       atomic_read(&ctx->futex_pending);
>  }

[Severity: High]
Could including ctx->futex_pending in io_local_work_pending() cause a busy-=
spin
in io_ring_ctx_wait_inflight() during ring teardown?

ctx->futex_pending is only cleared in __io_run_local_work(), which requires
ctx->submitter_task =3D=3D current. During ring teardown, io_ring_ctx_cance=
l()
calls io_cancel_local_task_work(), which drains ctx->work_list under
uring_lock but does not clear ctx->futex_pending:

io_uring/tw.c:io_cancel_local_task_work() {
	guard(mutex)(&ctx->uring_lock);

	while (!mpscq_empty(&ctx->work_list)) {
		...
	}
	io_submit_flush_completions(ctx);
}

If the ring fd is closed from a task other than ctx->submitter_task (or a
concurrent waker calls io_ring_futex_kick() during teardown) while an
uncancelable request such as storage I/O is still in flight,
io_ring_ctx_wait_inflight() sees io_local_work_pending(ctx) remain true on
every iteration:

io_uring/io_uring.c:io_ring_ctx_wait_inflight() {
		/* don't sleep on work that's already there and that we can run */
		if (ran_own && ((tctx && !mpscq_empty(&tctx->task_list)) ||
		    io_local_work_pending(ctx)))
			__set_current_state(TASK_RUNNING);
		else
			schedule_timeout(1);
}

Wouldn't that skip schedule_timeout(1) and spin in a tight loop until all
in-flight requests complete unless io_cancel_local_task_work() also clears
ctx->futex_pending?

> =20
>  static inline bool io_task_work_pending(struct io_ring_ctx *ctx)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022024701.1574=
811-1-austin.linux@gmail.com?part=3D2
