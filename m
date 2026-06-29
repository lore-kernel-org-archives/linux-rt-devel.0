Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587DA426EA8
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745546; cv=pass; b=BVWQmUgfRbPsfHgmRVRjgPavByGfK4mlgnsikCeQsVp5WDMstFiTECOJP/6EuCN1GJ8Hn4Qr6gMChflBayG9RMp8u7g9MCIbVHaqlwmo6RuPw6la7zTfL/I97giqOLzQ1YYPz7VfO/Horrb2aLaCYoBDngnE7pWkEiYmqFhN8pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745546; c=relaxed/simple;
	bh=XAAoNYSn/r3Ma8P8UYTG+xzlfsNSWQVIOqHGLCocNZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFZtkbUAkFizs7Y2u8fe/RBZZfPfZNC+x6WUE6apH6Tw6FSOzkiya5AU9dpWNhpt/2wvOJEVoTlenBIJgtjgxNPIQe0OMuGcUJzLfNlGzBH1G7RlWwq+n54iQYEmNGQp9CwbN8z79dJmXejbyrOrjvQG0NlUTJGmy6kvv6r+ZLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hjfh81gA; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hjfh81gA"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-695a3842230so16338a12.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 08:05:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782745543; cv=none;
        d=google.com; s=arc-20260327;
        b=YgQ4WxGPoGJjEQIMRVwVZW6Y1btz953nwLdwUdKOWoTqd+xXNsOyNkWz2mPe6SF9tw
         MF7jGDinyJEKBXEdo3Wrec8ApbX9LFlh3+I+arFrnlbEfQGCFmQ+TTjQEzePx8eDWX6w
         /V9gKrBVho0P8lHoyX0k4QayIik0yz0DcJ7MepWb/9d9s+vBm4EvVGjMHjKdgHyRVSZL
         39+BvWWrNS3GgpGpxkSTApdMlhMRpqzZtcGzlWN/vDJ+FFcmm8gPIsLIDCEvwCh/ucV0
         iH6cNuZIPoDKf6yiPOXGrExP/ig6qywdqTUEQurdpHEKNv5sxzBtKUfvxgNtCqCaxdnD
         g6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Kx6sIxZoXItf1W4sk9dkNdIelPfiZanaIqph2jO5EzU=;
        fh=ZJz+7U4Scd19BWoSbZVtYU25VslUcpnidDf+owiPV+E=;
        b=Ok+uc61LaFc69rUlCZfw6fIkJQ9ct3J2DNP2/DppWOJVMmdGniigp9ZJE8Gbinb3Y9
         576FFTN3KaXGzKWkyWp6QyStFfbzr8SWlwezZ7XyofZWwZvrGSxtVwVum2pT43NceA55
         SK4ykvARBzMvStDH7SiiY1X/L7Xg/9qR+CSm6OayCz4Z+ZSe2zQahfzG7GM2ctgx2FP8
         guFuaO3fFnhVEqa1ONRIpv/Pp1Jct/NkjOODM98fFSjyMK5kmA4HHbSkcijZjRYrZ0oy
         r3kMcIUiCxGqE6//sERlmRK17whlQTOFYYwgA3DJpG6Gv4tX0Iq6BY/iVTeUWNpHmrEG
         e0WA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782745543; x=1783350343; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kx6sIxZoXItf1W4sk9dkNdIelPfiZanaIqph2jO5EzU=;
        b=Hjfh81gAHIhpWKREg8Rz+kshQwe5afqfHZfIRVfQOm9bbb1gyz/VZ1v0VKGtBEEr+0
         T6c84+6NdGzyuiOiox2azf+oEAfGNwybpyCoG/2b6c3zWpHwnAV+ILYFdCo+ovaZab+t
         nuCpOQLukhdzglL5D3xoSR55heimLBuphcP80chWP5vS3JbsBTCp8Pk0ip81/3vBu/ey
         CcWBUmNYZsGLIIgqq+PhBb+2vnj52GL53UqcuAcGOF2TzGsfn38R+lG1e7cdvNK3ZKda
         X5bfvM4rFuQro3pFp41dUKwYcMejwQuwydGmWXF6OFEWKoNVCCkP8cZLoVxT2/kUU5A/
         EGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782745543; x=1783350343;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kx6sIxZoXItf1W4sk9dkNdIelPfiZanaIqph2jO5EzU=;
        b=rtbGCr5vcZBb1ZWURISo71FxKRrj+8D/ZL1tYx/BYRLhmvZAfUFrrLruFOW/w1Fbcv
         SCrofF6Q3XnFsDFrUvDYqpqUlI542++VSTe9cP67v6Ok4O9mxqJ8k++fF8rcAJuO8Euv
         J/n5wSQHrFSJCcflf6gzw6tiOf+BIXWIkBe7qiz3nDoXWoPliWVe9db+EDxJlVGP2kJx
         oic4mb526TsirYXVVnX5lyfLsPmq+R/Ja7UwDmEPtTkXtyw6NehxRWiJUZ7WyCmRSmWJ
         xPbeYef6xXWAbJ0f3aEQOPChL7GxgdgGPkvPZzMHIfe+oBpZV9RDORdlHCYpYJngmVkk
         KL7A==
X-Forwarded-Encrypted: i=1; AHgh+Rp2xj+/qgHZ6bZpWNTMOQ7Hu8mFWIAbJ08xYbeJib5mUlx0CJw+47istNc85FnZ0CMuELJo/Ck3Gbt+D59q8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWmBv2vGmYSP8zRu88kCrdOU8W9PCYFMqXHOlBiphcHc9aS36f
	Z9yn216Qrs9OKU+1T1a8kLHb814hlZDGze1dZQpP83GO6HgO4DuQvRGDAuNpo2Zvro2HMrByeLe
	gv33Nv3EQhDBoDcu29zVjWuBPF3z7lXvMudrd3vJ0
X-Gm-Gg: AfdE7cnpwBt7o+4Y6F2LjrRz+Ung9yF69drM6AYEcT6EOEXuNJBLjuBftar8zaDybKL
	RemheUCWJeYH4UxLKxlirKiMuOf76Ry4+yTW4kt3OKmq4joEqxCzu7lj/m/83XPebxa8QOl+VtH
	JrZ7u0zhpMNtI8AvDdp0MjPO57Gj6dgk2Gb9dovJQ5sV1dP5jV3wtoUqOjro8lK9aY7lKsEGp7Q
	5AauqjfuRbTzCvy8YLPohenzUOLDCIubQHlD6OTACJ7D/4Knp8iUopDwwFio6c67ykL5w3vQg==
X-Received: by 2002:a05:6402:424c:10b0:68a:83c2:9c75 with SMTP id
 4fb4d7f45d1cf-698795f58f5mr2358a12.0.1782745542255; Mon, 29 Jun 2026 08:05:42
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <akJ6Z2P8eMm1tc65@kernel.org> <CA+i-1C1CMgmPyqxT3dkLWVT34HqoPBi+0=GhF2rk2-wJSjSZng@mail.gmail.com>
In-Reply-To: <CA+i-1C1CMgmPyqxT3dkLWVT34HqoPBi+0=GhF2rk2-wJSjSZng@mail.gmail.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 29 Jun 2026 17:05:30 +0200
X-Gm-Features: AVVi8CfvejoTQU8KXVTesjH-swbBnnggwErReWWIPfe5O_Cbw4Rt2EVNnoBtZLE
Message-ID: <CA+i-1C10zQs8sGtQpR+jsPsQVCO+Y9VRXkgt9xikxgc2eCFWVQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] mm: Some cleanups for page allocator APIs
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Hao Ge <hao.ge@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dimitris Michailidis <dmichail@fungible.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jun 2026 at 16:30, Brendan Jackman <jackmanb@google.com> wrote:
>
> On Mon, 29 Jun 2026 at 16:00, Mike Rapoport <rppt@kernel.org> wrote:
> >
> > Hi Brendan,
> >
> > On Mon, Jun 29, 2026 at 01:11:49PM +0000, Brendan Jackman wrote:
> > >
> > > Some tweaks and cleanups for page allocator entrypoint and flags. This
> > > is motivated by preparation for __GFP_UNMAPPED [1] (which will probably
> > > become ALLOC_UNMAPPED in its next iteration), but all this is supposed
> > > to be an improvement to the codebase in its own right: unifying code
> > > paths, reducing API surface, and removing GFP flags.
> > >
> > > Tested:
> > >
> > > - KVM, mm, and BPF selftests in a QEMU VM
> > >
> > > - kunit.py on x86_64
> > >
> > > - For the ALLOC_NO_CODETAG bits I just booted a VM and read
> > >   /proc/allocinfo. I confirmed that if I remove ALLOC_NO_CODETAG, the
> > >   kernel crashes in early boot, so I was at least booting code that
> > >   depends on this logic.
> >
> > Heads up before the full kbuild report:
> >
> > CI has tested the following submission:
> > Status:     FAILURE
> > Name:       [v3,00/16] mm: Some cleanups for page allocator APIs
> > Patchwork:  https://patchwork.kernel.org/project/linux-mm/list/?series=1118244&state=*
> > Matrix:     https://github.com/linux-mm/linux-mm/actions/runs/28375636866
>
> Agh, thanks, I broke the build for CMA.
>
> I thought I had this covered in my local test scripts. I will fix that
> first then I'll send a fixup for the patch.

OK my scripts are indeed checking CMA, the issue is that I didn't
build with NUMA_BALANCING.

I guess Suren was right[0] and I really should build allmodconfig (at
least vmlinux) before sending patches. I was a bit skeptical that this
was an especially useful config to build, but now I realise it just
maximises coverage, even if it does so under a pretty arbitrary
configuration.

[0] https://lore.kernel.org/all/CAJuCfpHAMaK2sZYSgS750CvgksCKEfOmLzZasXdBup+CrS-3Pg@mail.gmail.com/

Here are the fixes:

diff --git i/mm/migrate.c w/mm/migrate.c
index d9b23909d716c..8e0a6fb3f6618 100644
--- i/mm/migrate.c
+++ w/mm/migrate.c
@@ -49,6 +49,7 @@
 #include <trace/events/migrate.h>

 #include "internal.h"
+#include "page_alloc.h"
 #include "swap.h"

 static const struct movable_operations *offline_movable_ops;
diff --git i/mm/page_reporting.c w/mm/page_reporting.c
index 7418f2e500bb4..c7325704c3202 100644
--- i/mm/page_reporting.c
+++ w/mm/page_reporting.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/scatterlist.h>

+#include "page_alloc.h"
 #include "page_reporting.h"
 #include "internal.h"

diff --git i/mm/shuffle.c w/mm/shuffle.c
index fb1393b8b3a9d..82a2c7725a08a 100644
--- i/mm/shuffle.c
+++ w/mm/shuffle.c
@@ -7,6 +7,7 @@
 #include <linux/random.h>
 #include <linux/moduleparam.h>
 #include "internal.h"
+#include "page_alloc.h"
 #include "shuffle.h"

 DEFINE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
