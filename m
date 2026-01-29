Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02A132F75B
	for <linux-rt-devel@lists.linux.dev>; Thu, 29 Jan 2026 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769722246; cv=pass; b=kNnKFPUI5I8Tx41MJ5ZSQbuoY+rWmsTcyL0wtBqjmOIQuVCHK28hph6RW62ToAwy5ePYlqym/EskNs9IUmAQqfuUgOFSDfR5fu6XZrpOIaTPxfcuftVvags5nnJbOiT2nJ/74RMuOwf634qdGC3b1iujMAUqJqVgtTYXUdFh4Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769722246; c=relaxed/simple;
	bh=rqLjDpUUNSiY+YyjTPDjCda4G1BOQx/wSvWpnCAssLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gi4mT2BaPtbZ5vLBkZr2aVMqFAZ0kNmDuHWBYBCG++obh6W90OBi1TXOuj+UDG4AHzziaLyntCYdk2ZyDXfoa1qQNHmAKMKm/QVKNGLbbBDtf2PeJSPo6/wOF5XHvinoA25yoIK7I9nO8DEHn6Avuq7Z9KVS0SUMC+rJGf1m3tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ocKWOOeZ; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ocKWOOeZ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50299648ae9so11201cf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 29 Jan 2026 13:30:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769722243; cv=none;
        d=google.com; s=arc-20240605;
        b=IvudOC/AALTFYdzeaOxzqqH5jHDlovRdKJOpjZ4AagxNSUlTJMvDg/pwpVJxZuBZM9
         ELZnIDT5H0cA+Syys9vqdh/HpO924PcGu0Po2TFUrBYj3EHAqsuNoqdTQjdHYm/92/m2
         CoVCoGi5WA6hZmt9lUXO0K8Wjw+R5tsY6ruGSRi0zVm4D/kgxErlVUVI2TENIlblmlzW
         fZrZxEqxLOnEQ2WCGX+kyIfPvq5vz7MnZInV4EC3PbeS70jDQp5KYQaRQYTJ3HbpzUsC
         3gdi4JnefqEHCkg40xUV4I2AP6J9KYS415Sg9dsyx9Wt1PWkVQAJ4GHO9e+SpyusUINM
         G76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JqxcN7KtTUu9rL1wIU9EI9qT3i6tnGntzVMiIiyYLMQ=;
        fh=qCY1Q3oojNu/5yOsP/v22UgsqZx7LOdaHKMzj2qWGy0=;
        b=gayYmqoUpm+DfKfKzaoTHm0hKc7l97DIQoWMKU6U7vZ2DrDM55Yri0poS/fj+1uIjL
         L77FM5lKuvHLzI8AqQX9QUnzDQc9Kpy0dt/QGGw6NFfCqIlVyDJ3R8wjZa8j8vGyw9kX
         j4KJEcuVSZj3OEwJvbxqJp5nG4hgNlB5OvktmxmZj//9OJFzvBEFLraNx4uGbQInNdw0
         vq5sS9BL3asKx3/CrawrXBgUXRDJRLE2bAQ8iCkWn/eYHoYItzOGF6tpaPQ4JlP2r3Ro
         DeFs4slvy79Dw1sWqb73tvmQHV8VIZUQJiAdmjkzbn/s/GSIs0McRLpCieS+km/8N6X2
         /ipw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769722243; x=1770327043; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqxcN7KtTUu9rL1wIU9EI9qT3i6tnGntzVMiIiyYLMQ=;
        b=ocKWOOeZx7IKSvIejJRNgyP7BAcuGuTmlb6qTAFSD0F5pAH6oDZZG1qxDzaj8cWizS
         7cemf/UYeRMf2Xg3Wv0cGwo/SgaLV6Zb2yhhlK6ZYo/3nefB2FNjJntKNcHyiJK9XuZr
         4zJgJpbTRN+WhtTXDCynWLGA10e5a1XYHxLEwuvNFpJ4jrRRo94E8CkRKxzIG2PKEGV+
         voTwrUBTNOo4TgDkMzlm8TUuW93hfRx1A6H7HPztK7iyxY7YL03sR9PpeY84keYtnCB7
         RDwRRBt3AzvpurbwZCwUArLeAKljbMwEkxlgDILLSlUYx9+xdfMBOKNQqOvpGKSNGG33
         4x1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769722243; x=1770327043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqxcN7KtTUu9rL1wIU9EI9qT3i6tnGntzVMiIiyYLMQ=;
        b=m8wg09X+h8IJ8Q+9AqR2e5dgIdOrQDE3OHCUUIXnm6l3WsafWTHqxMIsIvLuN+bWs/
         Tiw9VE3W/eu60kZ4YdVX19xF19C8cbDCW8+IqV5zo8TEHbTYigC0arydTLRSdn0BManu
         wm30g1QbODvCNxa3SNQSZ/0rCP3KDZnYf0QRQa78j/CbvQVyn+7NURdIwuznV1QOlHP0
         w0GLDY6reFFKuSnuULMzyMSjqxftGOeu52PgwInmuZ7odc1aOIbO8z740RtseQaxp/BQ
         vH0r96WDGS7KIRSDUae9XzyK+7YZdylmcozhEFr0ApG/oBbvGKz11JSNUMRQwymxtE2l
         +wCA==
X-Forwarded-Encrypted: i=1; AJvYcCXALFw+fhv+w5TDgtkCJ7yCU4/rGt7wMiuE8dEc5pL3PjcPUYsjwxRxZpELhTr8Br7sKT70ZYtiJEAliJd1/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOvfTxr3pbf+/rrDNz0BXlFF7orpsphU/o9mYymaUNs8edBEM9
	QIamUD6BiFtSQmoGyKPpcWT/LqPyWxfq0o/yJgVEasPyrvXi5sNvTYC7om+YzlyeGA5ShYXxZiC
	M17h3FEDJ5CF2DhKZmBar5s6/zF8Rh3pMqGNbISVi
X-Gm-Gg: AZuq6aKeKFEfIuxOVm3dZCjfGDW0VuLtqXb+Q2F44tczHG+WCkzFTQCcK2nxhspQ7mK
	KHs/4kgChjwkWw7w8X4HDmlngLCtYorQDBv491ucgqChTn8u7PH5YxcAHP6JaU5CdLlV4Qyf5hO
	7UPzvAUBaxNTxbdLYoCDcQmOp0u2+n4fmUsC6gQ1YzNb8Nd3O4aBD6ri+TB8MLDOevcxP+hry54
	XlHModVaUAE5dWGQyHGw4STGDnxPHwdedVakhBhByR6ZA9Bq2qIPAdXd/oGuSJ9vkmeaeDcAvmT
	XoeW0B0ThZOf7Euu+hlKoXFIyQ==
X-Received: by 2002:a05:622a:1a85:b0:501:197d:32af with SMTP id
 d75a77b69052e-505d282fe19mr1768141cf.0.1769722242948; Thu, 29 Jan 2026
 13:30:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769198904.git.lorenzo.stoakes@oracle.com>
 <fdae72441949ecf3b4a0ed3510da803e881bb153.1769198904.git.lorenzo.stoakes@oracle.com>
 <20260128113749.osNjwNqo@linutronix.de> <71c45f74-0fb5-4ec8-aa67-d700df94b617@lucifer.local>
In-Reply-To: <71c45f74-0fb5-4ec8-aa67-d700df94b617@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 29 Jan 2026 13:30:32 -0800
X-Gm-Features: AZwV_Qgm5gepZ8gbgQe6dEjUltBBWBnJtHfDRyEYqgKQxgjXh9yeS3JPa-VkvQk
Message-ID: <CAJuCfpG+Ci2JSskDuE09jzdReXP-06Bu7XfeHTySBwQXb_dYtQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] mm/vma: add+use vma lockdep acquire/release defines
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 3:48=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Jan 28, 2026 at 12:37:49PM +0100, Sebastian Andrzej Siewior wrote=
:
> > On 2026-01-23 20:12:14 [+0000], Lorenzo Stoakes wrote:
> > > --- a/include/linux/mmap_lock.h
> > > +++ b/include/linux/mmap_lock.h
> > > @@ -78,6 +78,37 @@ static inline void mmap_assert_write_locked(const =
struct mm_struct *mm)
> > =E2=80=A6
> > > +/* Only meaningful if CONFIG_LOCK_STAT is defined. */
> > > +#define __vma_lockdep_stat_mark_acquired(vma) \
> > > +   lock_acquired(&vma->vmlock_dep_map, _RET_IP_)
> > > +
> >
> > After going through the remaining series, I don't think I found a
> > matching lock_contended(). So perf/ tracing just give you a few
> > lock-acquired events. Wouldn't it make sense to also some
> > lock_contended() events where the caller had to wait before it could
> > acquire the lock?
>
> Yeah I did wonder about this actually. The series really just abstracts t=
his
> part, so I think doing something with that should be a follow-up.
>
> Suren - what was your intent with this? I did wonder what we actually rea=
lly
> accomplished with this.
>
> VMA locks are always try-locks.
>
> Write locks can't be contended against one another since VMAs are always =
a
> per-process entity and not obtained remotely, so either a VMA is write-lo=
cked by
> us or not write-locked, never write-locked by anybody else.

Correct, all paths which call __vma_enter_locked() to either
write-lock a vma or to detach it have to already hold the mmap write
lock on vma->vm_mm. So, lock_contended() will never be triggered for
vma write locking paths.

>
> Read locks immediately give up if the VMA is write locked.
>
> Would we want to record a lock_contended() event in that case I guess the=
n?

Yes, we could have it in vma_start_read_locked_nested() if refcount
increment fails and if the refcount !=3D 0 (if it's 0 then the vma is
detached and the refcount can't change concurrently).

>
> I don't think we'd want to do that if the VMA were detached, only if it w=
ere
> write-locked?

Yes, that's why we would need an additional check for 0 in there.

I can add this logic after your patchset lands. I don't think we need
to block it for this.
Thanks,
Suren.

>
> >
> > Sebastian
>
> Cheers, Lorenzo
