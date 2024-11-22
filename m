Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056816FF3B;
	Fri, 22 Nov 2024 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270362; cv=none; b=aHCg1DxmGvfkAb40XVO27JaUCU8NBp/T5K+ubfdiYrTO4x2PJuIfeoh5hdZSkvEzMqDPViqiRArreD2/pza0iZQMG7xSbutjoKH47sYA1q/oqxcPPm/nGuKh/Y/ECqx/0SFgnX9Z5hy/sEb/MYMMBJup1yUtod+59zP2tBxwPvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270362; c=relaxed/simple;
	bh=Tpk1JS0lg5bUOHKAXDM52ebptRJSSxoaGVDun8qJQtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9P0ruvoz2tLAIJEvyA3mA09VlJB+ukqBFc6hP129viIXPBtISzaJDIpNw8NKtniKWNKVVyX2/y2cJXhbdC3cwK+9PBC6V5b4Sb2bBoY86kb1wCdZ8h0gGcob80R7oOq+Oe2sym1XVPn1OUrDWA/i0dIhL6CrNrAbwG8yos2DGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8162C4CECE;
	Fri, 22 Nov 2024 10:12:39 +0000 (UTC)
Date: Fri, 22 Nov 2024 10:12:37 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Alessandro Carminati <acarmina@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Subject: Re: [PATCH] mm/kmemleak: Fix sleeping function called from invalid
 context in kmemleak_seq_show
Message-ID: <Z0BZFW1jdIwpFrGz@arm.com>
References: <20241120102325.3538-1-acarmina@redhat.com>
 <Zz332cG45rNSeE_B@arm.com>
 <20241120102602.3e17f2d5@gandalf.local.home>
 <Zz-HqbsWxFPrrjST@arm.com>
 <20241122081437.AKxGgM9n@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122081437.AKxGgM9n@linutronix.de>

On Fri, Nov 22, 2024 at 09:14:37AM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-11-21 19:19:05 [+0000], Catalin Marinas wrote:
> …
> > > Maybe SELinux locks should be converted to raw? I don't know how long that
> > > lock is held. There are some loops though :-/
> > > 
> > > avc_insert():
> > > 
> > > 	spin_lock_irqsave(lock, flag);
> > > 	hlist_for_each_entry(pos, head, list) {
> > > 		if (pos->ae.ssid == ssid &&
> > > 			pos->ae.tsid == tsid &&
> > > 			pos->ae.tclass == tclass) {
> > > 			avc_node_replace(node, pos);
> > > 			goto found;
> > > 		}
> > > 	}
> > > 	hlist_add_head_rcu(&node->list, head);
> > > found:
> > > 	spin_unlock_irqrestore(lock, flag);
> > > 
> > > Perhaps that could be converted to simple RCU?
> > > 
> > > As I'm sure there's other places that call vsprintf() under a raw_spin_lock
> > > or non-preemptable context, perhaps this should be the fix we do.
> > 
> > My preference would also be to convert SELinux rather than avoiding the
> > issue in kmemleak (and other similar places).
> 
> No. kmemleak has been made use a raw_spinlock_t because most of what it
> does is something that is not used in production on a PREEMPT_RT system
> and falls in the same category as lockdep for instance. And that code
> calls into LSM/ selinux.
> Before making the lock in selinux a raw_spinlock_t you have to think
> about the consequences in general and audit the code. From a quick
> look, there is also avc_insert() invoked in that callchain which
> allocates memory and this is a no no.
> Also, if you make the solution here in selinux to use a raw_spinlock_t
> you would have to do it also in every LSM as they might be used instead
> of selinux.

Good point, thanks. Kmemleak is indeed a debug tool not supposed to be
used in production. Modifying SELinux has wider implications for
PREEMPT_RT.

> Therefore, I still prefer adding PREEMPT_RT to the restricted_pointer()
> category for atomic invocations.

This should work. If one wants the actual (hashed) pointers with
kmemleak, I guess they can disable kptr_restrict.

-- 
Catalin
