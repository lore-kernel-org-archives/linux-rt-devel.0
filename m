Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55AE145335
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 Nov 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120582; cv=none; b=hl5K+DelcSONC6mBxmmicTaGXtBUYHblEI85TgZkSPIVAjVK23IHNa9BhN9vOKuxRWcOw50A/e/hwjk0n1gymM2sMTq9S9hspWwQfD5nBciwG1h6ZiZAU3JOll3kfC8VEnbihDkIokRrb+YxrP9msMPaWvsaV2ZZ7CdClDml3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120582; c=relaxed/simple;
	bh=VfR9wdxer9kVXX+JA4Pugu2yWhtmDNWs7LhPukfN9pM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a00fKAv8LeGbGInIm2jS26M6C7u5ZTnS56za7Pfq47vyzw/re3/aWrehQzWXj/XNkrvllpj4d3xboZAOkDqMA7vOULnV0KREIIPWRDk7nc2/5ZyZ+Vk0yEc1rgIlKZ0fAC7Oy/xNFmQXcq63A8XNhpNe8gFni9Qu2i5BpH+I3vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RiVh/hzr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiVh/hzr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732120579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhU3S0A4Mnpsnqs/3/13cFEa605q4UA1j817veP3A6U=;
	b=RiVh/hzrbl2C6NbK9kYda3B4naVZmX3s0UjEV5cv+H0RcJFKVF2SgPYumMgxhunHG3Ktvp
	Mcii5d+BSD3WzLjB2Qi0p2IgYjlRGVZpku+Z1LLAwP2zy42sRVjF4MsSa+BuS7rsHC6iKN
	A7UztKCT4UGaBdViIRzIUlgiXu6OT4g=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-byVlhwgINHG8JQPuIgIxFw-1; Wed, 20 Nov 2024 11:36:17 -0500
X-MC-Unique: byVlhwgINHG8JQPuIgIxFw-1
X-Mimecast-MFC-AGG-ID: byVlhwgINHG8JQPuIgIxFw
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-211555dce08so53590685ad.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 20 Nov 2024 08:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732120575; x=1732725375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhU3S0A4Mnpsnqs/3/13cFEa605q4UA1j817veP3A6U=;
        b=cC9VM+UTARNH8gjLFEOok8E4BKoVijGDzvmdIFzxIWWjAgQb4ijgBpikM9r0Mj682D
         XJfBuNz86mxB3Oo4vImBATsakcFDrl6RpJbiRkPrlZiIOuSG7zFxb78XWBbo/XsEZ39k
         CQvAzXexkCuWcBMsmmhaSyO5Srm1S6z57RS7exJeJ3U83DhYSlsopmTuOqPwyeIBpM7t
         kb43Yd16PLoUXWlMVSsAN2dMZNFa7FoyQHZLfWRwhSjhTMdeDzc7iWcd8ozHeHi5nVfI
         ipJiaBMtxkHO8+4irGyjQb4P4aw97CeoUCMCI/Yzl50jXQasLXIlOSSiOOOsr/6jHhI3
         pGgA==
X-Forwarded-Encrypted: i=1; AJvYcCUr9o4QFLRKXYoUOUfDz+FBKZQ5/lThVwoeJSDUcV6lnzE77TJcTr7v+JAFCN7iG1iQCFo5d3LY/vl8QM7dOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvNZbQx/rebM+eCJREDy9CwbM8v99ODYor1848+3/fsG6YJkp9
	ljyPa8CFjXCF5qoNl/U9mhUfH6Ye4ruir/LsizA0WfwNoGBROr2PLXn3ubsaLHMCaGbs+FauFes
	rSgRI2kmtNjvrMFdpISer7QLRufNI9xMprJPRfQpkzq8NsXu3/7woqmqtHP15O+u0aWzc84QNa5
	fqArswwT03I5BqT9uvzUJIo2FIwtIK4oI8M+Lh/hg=
X-Received: by 2002:a17:902:ccd1:b0:20b:b40b:3454 with SMTP id d9443c01a7336-2126f9fb108mr36420225ad.0.1732120575547;
        Wed, 20 Nov 2024 08:36:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEndC+AthKB1mpAbXnqOydUaK60UqI1oD1suHPMIJwIkfHNBJIHODhd4fFPf5EbSrZJ9RZvD8mL6P1+1iEOyY=
X-Received: by 2002:a17:902:ccd1:b0:20b:b40b:3454 with SMTP id
 d9443c01a7336-2126f9fb108mr36419915ad.0.1732120575211; Wed, 20 Nov 2024
 08:36:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241120102325.3538-1-acarmina@redhat.com> <Zz332cG45rNSeE_B@arm.com>
 <20241120102602.3e17f2d5@gandalf.local.home>
In-Reply-To: <20241120102602.3e17f2d5@gandalf.local.home>
From: Alessandro Carminati <acarmina@redhat.com>
Date: Wed, 20 Nov 2024 17:36:04 +0100
Message-ID: <CAGegRW74BOvkAmo4UiH-D45o4HijL7B4CPvEvNfze3AEoTKfCg@mail.gmail.com>
Subject: Re: [PATCH] mm/kmemleak: Fix sleeping function called from invalid
 context in kmemleak_seq_show
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Alessandro Carminati <alessandro.carminati@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Gabriele Paoloni <gpaoloni@redhat.com>, Eric Chanudet <echanude@redhat.com>, selinux@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nkhZU2oMVZs6p_XR-rjDzlh8EQcFDKgW-fAkACXlzj0_1732120575
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looping selinix Maintainers into the conversation.


On Wed, Nov 20, 2024 at 4:30=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 20 Nov 2024 14:53:13 +0000
> Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> > > -static void print_unreferenced(struct seq_file *seq,
> > > +static depot_stack_handle_t print_unreferenced(struct seq_file *seq,
> > >                            struct kmemleak_object *object)
> > >  {
> > > -   int i;
> > > -   unsigned long *entries;
> > > -   unsigned int nr_entries;
> > > -
> > > -   nr_entries =3D stack_depot_fetch(object->trace_handle, &entries);
> > >     warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\=
n",
> > >                       object->pointer, object->size);
> > >     warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu\n",
> > > @@ -371,6 +366,23 @@ static void print_unreferenced(struct seq_file *=
seq,
> > >     hex_dump_object(seq, object);
> > >     warn_or_seq_printf(seq, "  backtrace (crc %x):\n", object->checks=
um);
> > >
> > > +   return object->trace_handle;
> > > +}
> >
> > What I don't fully understand - is this a problem with any seq_printf()
> > or just the backtrace pointers from the stack depot that trigger this
> > issue? I guess it's something to do with restricted pointers but I'm no=
t
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
> seq_printf() is called. Normally, this is not an issue, but the behavior =
of
> seq_printf() is dependent on what values is being printed.
>
> The "%pK" dereferences a pointer and there's some SELinux hooks attached =
to
> that code. The problem is that the SELinux hooks take spinlocks. This wou=
ld
> not have been an issue if it wasn't for that "%pK" in the format.
>
> Maybe SELinux locks should be converted to raw? I don't know how long tha=
t
> lock is held. There are some loops though :-/
>
> avc_insert():
>
>         spin_lock_irqsave(lock, flag);
>         hlist_for_each_entry(pos, head, list) {
>                 if (pos->ae.ssid =3D=3D ssid &&
>                         pos->ae.tsid =3D=3D tsid &&
>                         pos->ae.tclass =3D=3D tclass) {
>                         avc_node_replace(node, pos);
>                         goto found;
>                 }
>         }
>         hlist_add_head_rcu(&node->list, head);
> found:
>         spin_unlock_irqrestore(lock, flag);
>
> Perhaps that could be converted to simple RCU?
>
> As I'm sure there's other places that call vsprintf() under a raw_spin_lo=
ck
> or non-preemptable context, perhaps this should be the fix we do.
@Paul and @Stephen do you have any feedback on this idea?

>
> -- Steve
>


--=20
---
172

