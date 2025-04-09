Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B8A263C97
	for <linux-rt-devel@lists.linux.dev>; Wed,  9 Apr 2025 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204490; cv=none; b=W3uHXa4USOI6HDF87x83iADQYYOpJ0H+X4F1pnwh/b7HhtwEsgUoYYO1E7b377Lc/2+FNcnqYP0+xUuOw1oeUqJT/ir7gO6J1LZi4/FwpgaCG0Iwy64grmFIvFG9ZF/TMTuLtmsPUOuAXs2Va8FcxwowIaNSR2kToYeDEx7BB04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204490; c=relaxed/simple;
	bh=u25LGCZIdSjN6AE0hX1UlAyX9gIz1PilxFeVVPHjXXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mm+cSPspfiUTpB9T3SWj8RJO4LH0mvNzps6acTMiwUmuQ1mVoAXw8tNenVgNJkfq8zyjoh8hPGF34kv7xGynuxsyiuGHcJuNk9USLyFPs+tWfShPo1f0d8LqoevxxBdW/G5ts4nmJLxTcdltCSSR28/1PVl1oehmM1M/AfE/7bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Id7OZdbs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FQl6kiX1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Id7OZdbs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FQl6kiX1"
Date: Wed, 9 Apr 2025 15:14:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744204485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVV12QUfdi94ySdl6Qtyyxmd1JDipjOsYbnKYe7A300=;
	b=Id7OZdbsLZSu6iXuT5wDiBqr08tl16hI63V9rc2dk+bgQXv+Q0QLpeRVEv+orNiS5svKkf
	CRWgErTlJ4cGd0+/KkXF0uI/OoPCdu9RkTEgjOAC7yQ3kZ6uFP6fXEHe8UM/7qEBxBOoCE
	Qj3ww4j7hUleCPCDu60e+EKuZROaJf7nB/A65BtrR4AuMHQQVoB/o3Ynmd3KMw/6jvMVvo
	/hsaafZeStTyozB1vO+gBwKJNSof7XDH6o2VfmtZyFj17EbEOQAd8rJBL0u3JpcQ4GVoZl
	bwM5U3byInHo4sgodtlWYLCMQU41gVDE5TUWnWkESrAd7eMEQjIOrMpCiUieiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744204485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVV12QUfdi94ySdl6Qtyyxmd1JDipjOsYbnKYe7A300=;
	b=FQl6kiX1obAY3aeAxfJt8N4wFHGADmBJGTV5iLBLOSwuREkrNNKzoK85dsGOklHU5JU9NO
	8H/Xwlvo+xOWZNBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Chanudet <echanude@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Alexander Larsson <alexl@redhat.com>,
	Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250409131444.9K2lwziT@linutronix.de>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>

On 2025-04-09 12:37:06 [+0200], Christian Brauner wrote:
> I still hate this with a passion because it adds another special-sauce
> path into the unlock path. I've folded the following diff into it so it
> at least doesn't start passing that pointless boolean and doesn't
> introduce __namespace_unlock(). Just use a global variable and pick the
> value off of it just as we do with the lists. Testing this now:

I tried to apply this on top of the previous one but it all chunks
failed.

One question: Do we need this lazy/ MNT_DETACH case? Couldn't we handle
them all via queue_rcu_work()?
If so, couldn't we have make deferred_free_mounts global and have two
release_list, say release_list and release_list_next_gp? The first one
will be used if queue_rcu_work() returns true, otherwise the second.
Then once defer_free_mounts() is done and release_list_next_gp not
empty, it would move release_list_next_gp -> release_list and invoke
queue_rcu_work().
This would avoid the kmalloc, synchronize_rcu_expedited() and the
special-sauce.

> diff --git a/fs/namespace.c b/fs/namespace.c
> index e5b0b920dd97..25599428706c 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1840,29 +1842,21 @@ static void __namespace_unlock(bool lazy)
=E2=80=A6
> +               d =3D kmalloc(sizeof(struct deferred_free_mounts), GFP_KE=
RNEL);
> +               if (d) {
> +                       hlist_move_list(&head, &d->release_list);
> +                       INIT_RCU_WORK(&d->rwork, defer_free_mounts);
> +                       queue_rcu_work(system_wq, &d->rwork);

Couldn't we do system_unbound_wq?

Sebastian
