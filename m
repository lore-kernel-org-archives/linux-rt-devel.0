Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BED6F06B;
	Thu, 21 Nov 2024 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732216751; cv=none; b=Jv7KXmpCucVhBD/41YbDWfF9E3kt/1adhh7dRH6Oj1Zmw896MC6YDs639cVyOnh30NWKQQPIzb3TYA2/klN3L8cd5fbsBVX1O7Ip5vDDHn5fjMdOqvMtH5/fOeGT3injifEK6KrtMTF7OleyHByld06Xl3GDr3O9D9m6QCwiDX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732216751; c=relaxed/simple;
	bh=4zzhtJ182ym5GUVMHb4Cal2kE8O5/2d1o5zZrpWg7lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+wEE6JZ+vrIFg+CdKcCnjeTEC39i6a0TuBaFn6nMeVUuX4OuEWfKmQlt2cXsje40nnflgrDwmEWnAYTutbxutkJ8OCsubMfpfKWWIZOYyKN1+qfw02L0YCwEjKWxABz4FSJY5o3AAu1y+fs7cjRsPlNEmPox7FFj4si32KYR4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B01FC4CECC;
	Thu, 21 Nov 2024 19:19:08 +0000 (UTC)
Date: Thu, 21 Nov 2024 19:19:05 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alessandro Carminati <acarmina@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Subject: Re: [PATCH] mm/kmemleak: Fix sleeping function called from invalid
 context in kmemleak_seq_show
Message-ID: <Zz-HqbsWxFPrrjST@arm.com>
References: <20241120102325.3538-1-acarmina@redhat.com>
 <Zz332cG45rNSeE_B@arm.com>
 <20241120102602.3e17f2d5@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120102602.3e17f2d5@gandalf.local.home>

On Wed, Nov 20, 2024 at 10:26:02AM -0500, Steven Rostedt wrote:
> On Wed, 20 Nov 2024 14:53:13 +0000
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > -static void print_unreferenced(struct seq_file *seq,
> > > +static depot_stack_handle_t print_unreferenced(struct seq_file *seq,
> > >  			       struct kmemleak_object *object)
> > >  {
> > > -	int i;
> > > -	unsigned long *entries;
> > > -	unsigned int nr_entries;
> > > -
> > > -	nr_entries = stack_depot_fetch(object->trace_handle, &entries);
> > >  	warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
> > >  			  object->pointer, object->size);
> > >  	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu\n",
> > > @@ -371,6 +366,23 @@ static void print_unreferenced(struct seq_file *seq,
> > >  	hex_dump_object(seq, object);
> > >  	warn_or_seq_printf(seq, "  backtrace (crc %x):\n", object->checksum);
> > >  
> > > +	return object->trace_handle;
> > > +}  
> > 
> > What I don't fully understand - is this a problem with any seq_printf()
> > or just the backtrace pointers from the stack depot that trigger this
> > issue? I guess it's something to do with restricted pointers but I'm not
> > familiar with the PREEMPT_RT concepts. It would be good to explain,
> > ideally both in the commit log and a comment in the code, why we only
> > need to do this for the stack dump.
> 
> In PREEMPT_RT, to achieve the ability to preempt in more context,
> spin_lock() is converted to a special sleeping mutex. But there's some
> places where it can not be converted, and in those cases we use
> raw_spin_lock(). kmemleak has been converted to use raw_spin_lock() which
> means anything that gets called under that lock can not take a normal
> spin_lock().
> 
> What happened here is that the kmemleak raw spinlock is held and
> seq_printf() is called. Normally, this is not an issue, but the behavior of
> seq_printf() is dependent on what values is being printed.
> 
> The "%pK" dereferences a pointer and there's some SELinux hooks attached to
> that code. The problem is that the SELinux hooks take spinlocks. This would
> not have been an issue if it wasn't for that "%pK" in the format.

Thanks Steven. That's very useful.

> Maybe SELinux locks should be converted to raw? I don't know how long that
> lock is held. There are some loops though :-/
> 
> avc_insert():
> 
> 	spin_lock_irqsave(lock, flag);
> 	hlist_for_each_entry(pos, head, list) {
> 		if (pos->ae.ssid == ssid &&
> 			pos->ae.tsid == tsid &&
> 			pos->ae.tclass == tclass) {
> 			avc_node_replace(node, pos);
> 			goto found;
> 		}
> 	}
> 	hlist_add_head_rcu(&node->list, head);
> found:
> 	spin_unlock_irqrestore(lock, flag);
> 
> Perhaps that could be converted to simple RCU?
> 
> As I'm sure there's other places that call vsprintf() under a raw_spin_lock
> or non-preemptable context, perhaps this should be the fix we do.

My preference would also be to convert SELinux rather than avoiding the
issue in kmemleak (and other similar places).

-- 
Catalin
