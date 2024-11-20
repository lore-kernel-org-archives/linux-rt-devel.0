Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDB7191;
	Wed, 20 Nov 2024 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116329; cv=none; b=nsLnav+o8rGjud9Wad2qlYeWlcjJd6Qqi7WmJ40yMiSwvrYrAX3aczho4nLm2fevLYcdTs6rlgdnxE4KQSwLevhIRueh52DalRF9XvwDNy3XkRiaJr7Q9JH0lWM4iwiUgHKVIdk4Docf2Jyc1xVgbwByaF8RVnY8YzrwVtOr+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116329; c=relaxed/simple;
	bh=kIG6lGz4gd7ogfkn7cosafnidYgvVj6qYiN3+h4433w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0QjVzRMCs7CML1reRhdVWCIzb06qnjFJzHlsPcnOnCC+LZZywMVizT/crbMOdGknuA5FXiIcLT+i902YB5m1+kNDqKdONOBe/Yr/ayIFnOzqW2ekpcwBDxP71sYm4fE5TAPzQX6xjrvbYbX0OuK9Q80ksxSSlf4VpSqGQux17A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183F7C4CECD;
	Wed, 20 Nov 2024 15:25:26 +0000 (UTC)
Date: Wed, 20 Nov 2024 10:26:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alessandro Carminati <acarmina@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Thomas Weissschuh
 <thomas.weissschuh@linutronix.de>, Alessandro Carminati
 <alessandro.carminati@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
 Gabriele Paoloni <gpaoloni@redhat.com>, Eric Chanudet <echanude@redhat.com>
Subject: Re: [PATCH] mm/kmemleak: Fix sleeping function called from invalid
 context in kmemleak_seq_show
Message-ID: <20241120102602.3e17f2d5@gandalf.local.home>
In-Reply-To: <Zz332cG45rNSeE_B@arm.com>
References: <20241120102325.3538-1-acarmina@redhat.com>
	<Zz332cG45rNSeE_B@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 14:53:13 +0000
Catalin Marinas <catalin.marinas@arm.com> wrote:

> > -static void print_unreferenced(struct seq_file *seq,
> > +static depot_stack_handle_t print_unreferenced(struct seq_file *seq,
> >  			       struct kmemleak_object *object)
> >  {
> > -	int i;
> > -	unsigned long *entries;
> > -	unsigned int nr_entries;
> > -
> > -	nr_entries = stack_depot_fetch(object->trace_handle, &entries);
> >  	warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
> >  			  object->pointer, object->size);
> >  	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu\n",
> > @@ -371,6 +366,23 @@ static void print_unreferenced(struct seq_file *seq,
> >  	hex_dump_object(seq, object);
> >  	warn_or_seq_printf(seq, "  backtrace (crc %x):\n", object->checksum);
> >  
> > +	return object->trace_handle;
> > +}  
> 
> What I don't fully understand - is this a problem with any seq_printf()
> or just the backtrace pointers from the stack depot that trigger this
> issue? I guess it's something to do with restricted pointers but I'm not
> familiar with the PREEMPT_RT concepts. It would be good to explain,
> ideally both in the commit log and a comment in the code, why we only
> need to do this for the stack dump.

In PREEMPT_RT, to achieve the ability to preempt in more context,
spin_lock() is converted to a special sleeping mutex. But there's some
places where it can not be converted, and in those cases we use
raw_spin_lock(). kmemleak has been converted to use raw_spin_lock() which
means anything that gets called under that lock can not take a normal
spin_lock().

What happened here is that the kmemleak raw spinlock is held and
seq_printf() is called. Normally, this is not an issue, but the behavior of
seq_printf() is dependent on what values is being printed.

The "%pK" dereferences a pointer and there's some SELinux hooks attached to
that code. The problem is that the SELinux hooks take spinlocks. This would
not have been an issue if it wasn't for that "%pK" in the format.

Maybe SELinux locks should be converted to raw? I don't know how long that
lock is held. There are some loops though :-/

avc_insert():

	spin_lock_irqsave(lock, flag);
	hlist_for_each_entry(pos, head, list) {
		if (pos->ae.ssid == ssid &&
			pos->ae.tsid == tsid &&
			pos->ae.tclass == tclass) {
			avc_node_replace(node, pos);
			goto found;
		}
	}
	hlist_add_head_rcu(&node->list, head);
found:
	spin_unlock_irqrestore(lock, flag);

Perhaps that could be converted to simple RCU?

As I'm sure there's other places that call vsprintf() under a raw_spin_lock
or non-preemptable context, perhaps this should be the fix we do.

-- Steve
