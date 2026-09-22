Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D1347FFE
	for <linux-rt-devel@lists.linux.dev>; Tue, 22 Sep 2026 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046993; cv=pass; b=QE9ZXgZe7lmXzMu8O/0UlVoJwcw9cJ6xHHs38O5YIcTaXWfRuRKy3hmAGN53C00m8oaCv53pKPvpHquhbivDsxWy2ZAA5YurXYf49NgioU9wpScN6bRD4gihXTNJyqiDRUldTJMk9TGpnDbRK089XP9asM0HN2/AohW5OdwZ8KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046993; c=relaxed/simple;
	bh=nxcBcIIu8q5gjVlpoqJK0T82KS5DXH91pbYJkPqLAyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6kL85MWPzlBR42lH+eRwDihvSK66T+giru22Z3mHx7wCJFsfEop7pydXvGqlPWcGTqWOKPi12USBeYF+4tL6Pf2oNRbYUOxT4FoYjJ9ESHFYsg8CLKbT+uXSiLrkzbmbgs2ENEpEjXnVPeqoUltkjcZgFqMfqesw8YQJtSlz2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q1SetWHY; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1SetWHY"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so19003535e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 21 Sep 2026 20:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790046989; cv=none;
        d=google.com; s=arc-20260327;
        b=Vm3EE6htV4kIad7saVV+9iD5LO3qh6QB+9cf6aqQAue79ce3Qen+4imy5wmHCfNFkW
         hSl2yixWi+R3Mpu6WtlgH9spjVceBpTbIITggZ+TNmSAZQoywCXRdGc9wyYAsUGdAsxP
         lbBsOn0JHXwqUdKICswNXHbHwDUDoVPDcpD/nsYRWgw7z/w+QQHX/+5MJrgTMwIO+ct7
         0oLC2T/wVxE6m7NNnm7dMO29r1OX7foOEypXV4AOQn5a9FsoGjA9Ab2eo4Ef86vPg2aY
         sVAFP7+gta3a9ihVyERLPewp7AA6hdI9MuDAsdkUX4K4dFSWYWaI2lWv6mSjJhcghYqr
         huVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T0hVWGyySlLly+28D7LGfZKDh0uXJmKT1sB0yr2I6gM=;
        fh=TFctdkkv7cRIch3Tsffas641QpUDkdmM0OyQex/cmTc=;
        b=RNOneUGlhgJb9TeO19J+fnhb9+dAw8RP4nQKbbFW4WlIV+NkDYLTOHcMyrPiFk6FBo
         X1mvPOp9CiSIlYYwqBXuvUv3uJOL3ZPIwUEDBIZ30n+2BWaeIbA8KLlWR+dxa3DrN9jo
         0s5LKq0vSB3z9hX8yAqF/cJFroJ33JHDI5SgYxDxXzI7pSs4tkJ2RRFfNBOr0cv/7w20
         XoclxanzAS64DHK4krK9AXV4uM3pOCnr7aqJHerpCZsXF70jo0qdeKQxa9liu28UBoTX
         SmCdVrYuQ5LZ7+F/K9ss6pcNReOvFX7Auxubte34Y4//jL/cQOpmltKOxPOFHfPwyiCy
         iquA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790046989; x=1790651789; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T0hVWGyySlLly+28D7LGfZKDh0uXJmKT1sB0yr2I6gM=;
        b=q1SetWHYm+7cTlO8hMjh4UpRj0yUOzS62UrmGqwJYqyFeUILycOyf0wuY7FPVGF4lj
         GBk+w3IrV2XDrjPGSq37+Gz1LFZGEj9UyBVrEJdil4QSAhEORWUSMh8UP+Pj7UkTKhlK
         0RT8Bp1AkAN9rocTkIQcolWQuLFH/xy1gRR8yRdpmGM604hSuOjIwg+UF/jsL9ouH8M1
         guN6FETinECWG9fTeE5fWvwBpkHS1apB6RAgQYhsMLbAxG6g7MSopzyL5jQdlhTFBH2e
         qgVMA17yqaAHKn2XwPT4GpgPSfAIHB57u9UJdp9l2EfHJMxOKTWIcfLDTmwW3OGik6T+
         yv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790046989; x=1790651789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0hVWGyySlLly+28D7LGfZKDh0uXJmKT1sB0yr2I6gM=;
        b=QyzKsQqSwgQkGC0v/AiX8/GfpsuZBeutEgWbI9JBXip6bsOT90nk9LnBbHsR0TVL+8
         ai+zvwAL8ETmre+PIjmoP8L4DbSERrtND6vTycZ1dyYcQbgWoz2vfjdCyhgfo/Tg7u0o
         SWZbmZBi5llJtoLvjx2wkFeD99gzub4hRavQdxuGR8xFUjSBmnaTESF4GMyj1j8YTa1I
         7CeHA7A8oBugmlDRFgHk8rC7M1A8lMb0o4zoSRYx6YDQpm5ToZ3DN4wDbr+RCUDnCjw0
         I77MypF4Hwonh1JtqwgzxZWD9AH9auoNMuLPCVlrzYEzeKplWXRZl6mmwqddEe6oKzTL
         4w3A==
X-Forwarded-Encrypted: i=1; AKwUvBxZczgHxtA84Vif0bO8cr6lB1gSKpPyj5QpGTD+c5Nk0YzIpHTujrY3YpH/26vcAqvhQz+ewuc2WrGL9B9zNQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lGsWyEYOTXXhlU4+ZFlBDQHwJ/mUSvuIjZFUARdHcVenzpof/E
	SNrAJq/B/FIs+t7nRo+cOpl19tR0RpmgI2Itzdkii4KSzckFhQYLwM5dOXtDc9RAiMV8kUAW88S
	JTnLP1VQXvZz9ApqCxmtNnENMIN+z69U=
X-Gm-Gg: AYBFou3BUh71oxXcNfh08arUQsZC4mW5ZO0+MW4XEyRsWqKbAackLBKzEXxjEhA1YTC
	zSMWZkeWefpVsWrdoefWzinA6PvltjjGpKIAUYTbDHAkVD/87z0FeW/bvuYTyuDhl1L5okJwhYe
	viGD+L4OVzLT308w3qZ5gjkx6htd8+bAyokRJsRZamKmvstEzyX8TI8jcQG6T4GkUee8GESLbWU
	OWWyVreWniOSqN+OEP7Yhzuj3DFv18Tre6b/2aZPOQrGeDXc3+qXMn52x9xqFuWYGSz+r0A4n+y
	N+bYvtl7vXIm9iRdXO6AeKG3Rgc/Qdcst7u6Dzi02NW2RfqZzzFHoyRyk7pkrkDLPJ10BLYBH39
	4TO4xX1s93wUbpw==
X-Received: by 2002:a05:600c:46cc:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-49fc566951dmr171043015e9.7.1790046989155; Mon, 21 Sep 2026
 20:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260920211920.928306-1-dwmw2@infradead.org>
In-Reply-To: <20260920211920.928306-1-dwmw2@infradead.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Tue, 22 Sep 2026 11:16:17 +0800
X-Gm-Features: AcwNN1WrYNyWGp1bGXe-bJN9POYZPs3FjeCDYohf8fnVdXEdiDT26MiduZxqtjc
Message-ID: <CAN_Opa9YWJZxr=YEjnkS-Khm=83P-xqGVZ6tq2nVQzMNOiThbg@mail.gmail.com>
Subject: Re: [PATCH 00/17] KVM: Use atomic SRCU for gfn-to-pfn cache,
 reinstate guest mode for x86 nesting
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Paul Durrant <paul@xen.org>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Fred Griffoul <fgriffo@amazon.co.uk>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Kunwu Chan <kunwu.chan@linux.dev>, 
	Zqiang <qiang.zhang@linux.dev>, Boqun Feng <boqun.feng@gmail.com>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jason Gunthorpe <jgg@ziepe.ca>, Michal Hocko <mhocko@suse.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Keir Fraser <keirf@google.com>, 
	David Matlack <dmatlack@google.com>, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Thanks for the series. I noticed the testing results, but didn't see
a performance comparison for the SRCU change itself.

Do you happen to have any numbers comparing the GPC invalidation
latency with regular SRCU vs. `synchronize_srcu_atomic()`? If there
are also numbers with the reader-free fastpath, that would be useful
for understanding its impact as well.

No need to run anything specifically if you don't already have the
numbers.

Thanks,
Kunwu

On Mon, Sep 21, 2026 at 5:19=E2=80=AFAM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> Now that Paul et al have so kindly provided atomic SRCU for us, it would
> be churlish not to use it.
>
> Based on the merge of kvm/next (d4b7fb647204) with Paul's dev.2026.09.17a=
=C2=B9
> as posted last week=C2=B2, this series:
>
>  =E2=80=A2 Converts the GPC to use atomic SRCU, ditching the rwlock which=
 was a
>    scaling and latency problem, and which PREEMPT_RT hated because it
>    turned the rwlock into a sleeping lock.
>
>  =E2=80=A2 Cleans up the intentional lack of dirty-tracking of Xen shinfo=
 and
>    vcpu_info pages (Sean).
>
>  =E2=80=A2 Converts steal-time / preempted status to use gfn_to_pfn_cache=
. (Carsten)
>
>  =E2=80=A2 Reinstates guest-mode pinning: replacing the old GUEST_USES_PF=
N mode,
>    letting nested state pages be cached and pinned while in guest context=
.
>
>  =E2=80=A2 nVMX: Uses GPC for the L1 MSR bitmap, and guest mode for APIC =
access
>    and vAPIC pages. (Fred)
>
>  =E2=80=A2 nSVM: Uses GPC for vmcb12 / MSR-permissions / IO-permissions p=
ages. This
>    cuts the vmcb12 transition cost measurably (selftest included).
>
>  =E2=80=A2 Returns -EAGAIN from cache lookups which race with memslot upd=
ates,
>    and re-posts KVM_REQ_GET_NESTED_STATE_PAGES on memslot generation
>    bumps so pinned caches are revalidated lazily.
>
> Tested: rcutorture atomic-SRCU (srcud, reader_flavor=3D0x10) on three
> hosts; KVM selftests including new invalidation and transition tests;
> >1 week soak of VM lifecycle + invalidation reproducers on 128-way
> RT+KASAN+lockdep, 192-way RT and 192-way PREEMPT_DYNAMIC hosts. And
> booted an actual Xen guest in QEMU a few times...
>
> =C2=B9 https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.=
git dev.2026.09.17a
> =C2=B2 https://lore.kernel.org/rcu/20260919003521.3134552-1-paulmck@kerne=
l.org/
>
> There have been previous series which attempt to deal with various parts
> of GPC locking, and the steal time one has definitely been posted before
> a few times, but let's just call this v1:
> https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dshortlog;h=3Dref=
s/heads/gpc-srcu
>
> Carsten Stollmaier (1):
>       KVM: x86: Use gfn_to_pfn_cache for steal time / preempted status
>
> David Woodhouse (10):
>       KVM: pfncache: Use atomic SRCU for readers instead of a rwlock
>       KVM: x86: Request the guest TLB flush from record_steal_time()
>       KVM: pfncache: Add guest-mode pinning (GUEST_USES_PFN successor)
>       KVM: pfncache: Return -EAGAIN for a lookup which hits an invalid me=
mslot
>       KVM: x86: Post KVM_REQ_GET_NESTED_STATE_PAGES on memslot updates
>       KVM: x86: Move nested GPC lock helpers to x86.h as kvm_gpc_lock_pag=
e()
>       KVM: nSVM: Use a gfn_to_pfn_cache for the vmcb12 page
>       KVM: nSVM: Cache L1's MSR permissions map pages
>       KVM: nSVM: Cache L1's IO permissions map pages
>       KVM: selftests: Add nested transition benchmark
>
> Fred Griffoul (3):
>       KVM: nVMX: Implement cache for L1 MSR bitmap
>       KVM: nVMX: Use pinned pfncache for L1 APIC virtualization pages
>       KVM: selftests: Add nested VMX APIC cache invalidation test
>
> Sean Christopherson (3):
>       KVM: x86/xen: Extract delivery of event to vCPU into a separate hel=
per
>       KVM: x86/xen: Explicitly tag "shared info" page as never being dirt=
y tracked
>       KVM: x86/xen: Don't dirty track "vCPU info" page
>
>
>  arch/x86/include/asm/kvm_host.h                    |   2 +-
>  arch/x86/kvm/msrs.c                                |   7 +-
>  arch/x86/kvm/svm/nested.c                          | 112 +++-
>  arch/x86/kvm/svm/svm.h                             |  16 +
>  arch/x86/kvm/vmx/nested.c                          | 356 ++++++++++--
>  arch/x86/kvm/vmx/vmx.c                             |  11 +-
>  arch/x86/kvm/vmx/vmx.h                             |  16 +-
>  arch/x86/kvm/x86.c                                 | 181 ++++---
>  arch/x86/kvm/x86.h                                 |  33 ++
>  arch/x86/kvm/xen.c                                 | 279 +++++-----
>  include/linux/kvm_host.h                           |  86 ++-
>  include/linux/kvm_types.h                          |  52 +-
>  include/linux/srcu.h                               |   7 +
>  tools/testing/selftests/kvm/Makefile.kvm           |   2 +
>  .../selftests/kvm/x86/nested_transition_bench.c    | 204 +++++++
>  .../selftests/kvm/x86/vmx_apic_update_test.c       | 299 +++++++++++
>  virt/kvm/kvm_main.c                                |   9 +
>  virt/kvm/pfncache.c                                | 596 +++++++++++++++=
++----
>  18 files changed, 1876 insertions(+), 392 deletions(-)
