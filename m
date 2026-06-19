Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A68B37B3FD
	for <linux-rt-devel@lists.linux.dev>; Fri, 19 Jun 2026 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781892512; cv=pass; b=lMeGlCUpipMB4y9zvfPYqP+kv95Lr4Qt90lHaIBLhpxtMyEMPl3iLExr/wF7kJZFWskUZpIlk2Ve0oSv79X8+GfLMq+2CC9tFJYQcERbq9J4QFrqJVUUMSichFMHMX+YTQW6Ir2ldcdeq4Aycs5T9l3MkCF78koLj00SgZcdByY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781892512; c=relaxed/simple;
	bh=Dd1NURQbBhXqZV/nmAedRTQKSPm9vCe2uEPlj8ydBHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQo93cmwt+VgVbqkK8rtaXlD4zHHigR1gELgbQ2F50lRZPEkIEZgmSK+giXdXNcyFqhHPLcTVNJuurXNXsj2xvatpwmvsivmZ+RT+2LVDt0lo78R0DrQQZ6mLwTcpKo3WSBtboeiXsyxeahCCOnVepOKL5ycnREwWap4Yz04ROo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C5/wj1Qz; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5/wj1Qz"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51765531803so356721cf.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 19 Jun 2026 11:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781892510; cv=none;
        d=google.com; s=arc-20260327;
        b=fz+kkIBHPkkVM+57lzpnVhlJMpOZqRzT+tdP1x4YBMY3ofcS/vaQFBFH31ZHbuHRWX
         5vfqRmVn1w955x2EXwR7w5E4NE4J3oUL74MyXMRN/7dSAAidE42IbFYoFpWQ6prRyWqQ
         pdpq9IOjTigCw7WynOGZTyioxojOPlNXGAy31oeEekV221+BVd1bBM85bJ8dOOpaWKLJ
         PMZlafrYS+PW7M/yLdA3qkq+6sH1nb808iN97v46bOdgpK0reBVR9+d2GAstpaCiUxEs
         deyn1kd4syqMguB+s6rNL2FdWGkMlw/b2dZ1EiHSFCMLved/pu5eYKUdAtYbcAGS/Kr2
         hIng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=if+w51pfEbXF0aIKIU0/YXuwi1jZSWlejSs+38AZ5sI=;
        fh=piVByAQ3cbddrRKzH6YbS2oxtHWqn7J7JbrDqkWlvFk=;
        b=D9ybKHl/JdzdANQilarLLD5aEsk/jKBh79Tyqr82Suq7n3/ooE5Jx+bTHg7eW1T2cT
         ofcpXIGoTsjWv9sRA/mqS46prFreCEMczOT6mMycveXyqjKCl9wcudyzgjb7lcA1f0z7
         JuzaVGpZtRzLpWqrCVoj6M9QNYZDSHp7dcdVudxunh5DvkBBstWCFhxDHHCigamYJ19k
         iz0fQYwS4d81q6DvkmOIOaE/CTu3piurM7d5KmSlFGysM4q0xQxM48vYsrO5jMDYKhpJ
         dlqb1T1ZVkFzgqmvNATtRde6wtWwyA9BuUqNFR+qB3A2jkjfeMgAxyajAsHyAcAYOOld
         hjyQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781892510; x=1782497310; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=if+w51pfEbXF0aIKIU0/YXuwi1jZSWlejSs+38AZ5sI=;
        b=C5/wj1QzavcJRzqy+M09oUrNk80HPrd5S4YpLj884KMdZCyi+D2AlrNpRoVDzbE/5N
         AqlqZK/+Xd24zpmalOEw3qbWAgwuVmoN3aOht4hKWrACWU91IGvkv5gooPQHq25t17LF
         r/LMOEYY+CwdPMkYTZEtbg/b+Y33S0mun9Z4f9jsu6abb6sYR35bWpBn+q4DhEFEaDxE
         5kV0BucW2VB9eyeGLR5MOOIDX2PVA9+bS5Bo7W7Xvc//rbwEereKLmdOoeC51yVpxMnW
         I3rFzL3/0S4j5zarRh+Mlz/AFK5VTAscY9EIFaGqJVZRioYds5lWVANWzZ/65WRShf3y
         Lv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781892510; x=1782497310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=if+w51pfEbXF0aIKIU0/YXuwi1jZSWlejSs+38AZ5sI=;
        b=st+X5xADRpkI3aifFt1MdAXnKT1w4SQLCyo7k7DXfk+P3cfL3/FdhJp918wiVhNmt+
         6vzyu93MUd/4bhBpDIo2AnlrvZgOz4BNhqDVqev7waV7VmJvUpwj3FA0ehC5S1azsA+e
         CbnJwac2pV3+wWh/L9d2CGrza4QkM0pebRfu320MOs1n9fuucRepTjeMuMXThNNOJLgK
         Q+1tHN3LBWdHBuE00ncq8tWLxxCZKm6V6jJi31kJVBxHhk+JWZGa5jQeeYJ6gLpgPSPp
         CO7lz+meRmmuFf41RIOo/l6ffGvmpJNRIfZBlPGO+5nFTP+RU9JhJtE5qhBdQRvQzriZ
         jfEg==
X-Forwarded-Encrypted: i=1; AFNElJ8L/jr+J5ZBt9zNY0lkVZ8aR5mhpA91c51w9B2rpKm0d7cMy3cCPASDNNHLaxxNGsPmPljaeE2ntLZP1A7kpw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6l0MOI7LPwIdSh4BXYLmMU9YFsi1EDI2UPmJWFAvfaNCQQ39m
	yGfPkFwpEYdTz/Xi/0PZg0I4zRH2hNweAaAeJwk+oNoSdmr8H93V6bNRViotDtuRSK5mbUyoSjJ
	Ga7AJL9cFOATccPoYeBnj238ctPZMJctPgdLaA8uJ
X-Gm-Gg: AfdE7cnLn9fEZXw1091yIhyC1bfqGs4kNJehPjZDsW4F2djpzZO+C9FKVkvDGduOxjL
	UI6Xab7jVLpFClXZrap7XbCy6/40OWMyBg0A/HFg3oc0EQp3VxtUlkcllIjfrPrbuXzKlv0SYoq
	RS32c1qs3PsyxHUCmPBYlvnXqduCiY7STGbUdrjEZAL61oZKYmnsY0TdGJ2KipSYTgtD+mS5r59
	ET+4V6HOE9G7JvmPk+EIYOcWe9MY30VCBJxr+CY+HpjOc1Dha0Ehqmb5CK6Bh9mYxAhdtg=
X-Received: by 2002:a05:622a:1b1d:b0:516:3def:1cf4 with SMTP id
 d75a77b69052e-519e877e8c5mr8151881cf.1.1781892506298; Fri, 19 Jun 2026
 11:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260617-alloc-trylock-v1-1-83fd7858832e@google.com>
 <2399b3ad-4eac-4a14-94c3-27e9f07972a1@kernel.org> <CAJuCfpG48TmvaiaRvnL-NXKU6nn55D3bks2DgzAc0URsZhAxqA@mail.gmail.com>
 <DJBHRVM65A11.1OL2M9MXN56H@linux.dev> <45fcc57a-ec8d-46d6-9c28-065d001c081f@linux.dev>
 <DJD0AGHTWYRN.1YWG5MDH87WVO@linux.dev>
In-Reply-To: <DJD0AGHTWYRN.1YWG5MDH87WVO@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 19 Jun 2026 11:08:14 -0700
X-Gm-Features: AVVi8Ce-wKSRl9HZnLx7RL1pqEgargGWpGuNyAl9oa2UQznN8ojLU8He4KFHTmo
Message-ID: <CAJuCfpGtymV=Tmsvs8Z-oF6pi7mD54mRiZNZtpF3UpYwBL7Uig@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: unify __alloc_frozen_pages[_nolock]_noprof()
To: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Hao Ge <hao.ge@linux.dev>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Brendan Jackman <jackmanb@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	"Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 4:57=E2=80=AFAM Brendan Jackman
<brendan.jackman@linux.dev> wrote:
>
> On Thu Jun 18, 2026 at 2:22 AM UTC, Hao Ge wrote:
> >
> > On 2026/6/18 01:14, Brendan Jackman wrote:
> >> On Wed Jun 17, 2026 at 4:49 PM UTC, Suren Baghdasaryan wrote:
> >>> On Wed, Jun 17, 2026 at 9:39=E2=80=AFAM Vlastimil Babka (SUSE)
> >>> <vbabka@kernel.org> wrote:
> >>>> +Cc Alexei
> >>>>
> >>>> On 6/17/26 17:29, Brendan Jackman wrote:
> >>>>> Currently the core allocator code is controlled by ALLOC_NOLOCK, bu=
t the
> >>>> It's not, it's ALLOC_TRYLOCK! Thanks for proving that we need to ren=
ame it
> >>>> to ALLOC_NOLOCK:
> >>>>
> >>>> https://lore.kernel.org/all/DJ9QPTO2WXNB.10E88ZHWRDHB0@gmail.com/
> >>>>
> >>>> So you just won the job to do the rename :) I think it should be don=
e before
> >>>> this patch, so that the new usages and other _trylock names introduc=
ed here
> >>>> can be done as _nolock outright.
> >> Ack. I'll aim to send that tomorrow once Sashiko has caught up.
> >>
> >>>>> main entry point function is significantly different from the norma=
l
> >>>>> __alloc_frozen_pages_nolock(), this is tiring when reading the code=
.
> >>>>>
> >>>>> Plumb the ALLOC_NOLOCK control one layer up in the call stack: crea=
te
> >>>>> an alloc_flags argument to __alloc_frozen_pages_nolock() (which is =
only
> >>>>> exposed to mm/) and then turn the nolock variant into a thin wrappe=
r
> >>>>> that just sets that flag (as well as handling NUMA_NO_NODE, similar=
 to
> >>>>> how some of the wrappers in gfp.h do).
> >>>>>
> >>>>> Rationale that this doesn't change anything:
> >>>>>
> >>>>> 1. Simple bits: A bunch of the nolock-specific handling is just mov=
ed to
> >>>>>     the new alloc_order_allowed(), alloc_trylock_allowed() and
> >>>>>     gfp_trylock.
> >>>>>
> >>>>> 2. __alloc_frozen_pages_noprof() has some extra logic that wasn't
> >>>>>     previously in the nolock variant:
> >>>>>
> >>>>>     a. Application of gfp_allowed_mask; this only affects early boo=
t, and
> >>>>>        only flags that affect the slowpath get changed here.
> >>>>>
> >>>>>     b. Application of current_gfp_context() - also only affects the
> >>>>>        slowpath
> >>>>>
> >>>>> 3. The slowpath itself: this is now just explicitly skipped under
> >>>>>     !ALLOC_TRYLOCK.
> >>>> I'll have to ponder it more closely.
> >>>>
> >>>>> Ulterior motive: adding an alloc_flags arg to the allocator's
> >>>>> mm-internal entrypoint can later be used to do more allocation
> >>>>> customisation without needing to create new GFP flags.
> >>>> Ack.
> >>> I think this change might also help us in removing __GFP_NO_CODETAG
> >> Nice, this actually looks trivial? I can probably just tack it onto th=
e
> >> v2 for this patch/series.
> >>
> >>> introduced in [1] and being the only user of __GFP_NO_OBJ_EXT once
> >>> Vlastimil's patchset removing other __GFP_NO_OBJ_EXT users lands.
> >>> CC'ing Hao as he is brainstorming ways to remove __GFP_NO_CODETAG, an=
d
> >>> this might be the answer.
> >
> >
> > Hi Brendan, Suren,
> >
> > Thanks for CC'ing me, Suren. This is indeed a viable approach
> >
> > and I believe it brings us one step closer to removing
> >
> > __GFP_NO_CODETAG entirely.
> >
> >
> > Brendan, I'd actually put together a rough local implementation
> >
> > earlier with mostly the same core idea as yours, and this change
> >
> > would indeed be minimal based on your patch.
> >
> > Thanks a lot for being interested in tacking this into your v2 patch se=
ries.
>
> Oh, I just took a look and it's a bit more fiddly than I thought because
> alloc_tag.c is actually in lib/ not mm/.

One option is to move alloc_tag.c into mm/ (while keeping more generic
codetag.c in lib/). From a quick look, that seems doable and probably
the easiest approach.

>
> How did you tackle that, can you share your implementation? It would be
> nice if we can avoid exposing alloc_flags in gfp.h.
