Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDA6302146
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768596365; cv=none; b=snZgbUFmZrjUTljuDTdpkQWre7ha3q30QiNQeVN7Sy07R0okp54XNvs/WHQTHgeen4Dk6Y0+bXm7kDbNMOWOkn6fosdXZwDjiXo7xnu3zCmTrTVDsbKRR4GfDyAWquTK/ewQ4xiGLr6ill0TF6fYT/Hm6/y5Q9dgI0f10gEhIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768596365; c=relaxed/simple;
	bh=b25spK90jju2kGiZYtSYk1J9VFSFffW7t1SG/KkwWfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bv5XhixIplqM1pYA0yinW9n81Gb+zP4IlgXyqqY56PyAKPFBvGVHnYCC7Vb5dlRmZByrJartKoG8TVm5fTWuKmQQ2uuoYDzcxC+SBENdJhNhMInYbJdO1kZYaAkgKkB7mjmqoCGihtM4FgUnIUh9hsJNr6B+8nVSw0QaYZv8jDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=normal.zone; spf=pass smtp.mailfrom=normal.zone; dkim=pass (2048-bit key) header.d=normal.zone header.i=@normal.zone header.b=ipOHGeCI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nF7bx1uy; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=normal.zone
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=normal.zone
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=normal.zone header.i=@normal.zone header.b="ipOHGeCI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nF7bx1uy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 8C50A1380232;
	Fri, 16 Jan 2026 15:46:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 16 Jan 2026 15:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=normal.zone; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768596361;
	 x=1768603561; bh=SPM+Di8o83qZm/G1viX3w5UQo8dmbrCLtR+QmZaB1C8=; b=
	ipOHGeCI8vfuwbJ0G9BTZGmspdG4P5IZW3lUtHQErzD1F4wjLAuPb8DU+ryQ0qwf
	H6n0d8ZWSgcREtGtlFKruEN+XfdWRBDs8fHLyxvfmNCh489LMQuPiVIhCqOoG/DF
	PMKlLHINJRTL5RC3wwlhblck14xotvnfFX3AUIA2E7SEiG9t6J/mkrUSpXZNhTp8
	ukprLrMfdMAjQLNLBvHrmCr1doJf4W2IJKfPPPJ0oIOq+dcRy8dn1wKOZBa48M8l
	CGgZ9BFadQ4OiS5o0e19CnhCOv+XFHwUX3VYBRIZtpMGieOoeQHCnyBLyMh6FMRI
	dDCufjfWrkRvn30mvI2j1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768596361; x=
	1768603561; bh=SPM+Di8o83qZm/G1viX3w5UQo8dmbrCLtR+QmZaB1C8=; b=n
	F7bx1uyakl60BRpwIW31+byfz4QrvE2o5vXuIUGy04BFX22PtWNq9A7URwL8mJ5a
	3i6bimYhvfsnKBiskrJEt5Ehsa2Hy0w1lE+cAG5hOKpReFpkR/bdOL0ToMJGy+YF
	CeBE0v/1FSnl4C0/MZp1vsXHWyT8XP/v5VpJUlCk+23zg+MGnzwikTK0ArV4tQ9V
	RXROaVf9JzHKdaEccWXNRcU/GP/WRbtkZoNTYxHvRxY6aJdcciac6TTQ+oCLRPO9
	jy9MeLs8howzDy8Jndjtw11VT2iVUd93TtEN8FYP8kQKi22XScgc2TLgujPT/JFZ
	FglKAIVnAxt3dJkNiezrQ==
X-ME-Sender: <xms:h6NqabjIlOuS08v6iqpksVNSe5Yc_cyNZ-kzhy0PVBK949vOrajCZg>
    <xme:h6NqaZV3IDKvfn-SRAnBv8R_8BT7dIk6qL9RbDWL1WzZwdZy1lWFd7hq-bke3XJn6
    T9_PhFMxt3sT5BLECbd6Nibfncc5wkENPQ4esWRB7tbzZXvISs6TjM>
X-ME-Received: <xmr:h6NqafvMzZGJkNVEeMHLPUn-pN5Cgo41CSMQnxDNgbKqwyzAnQbbXuMOLfdm5ZwEdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffokfgjfhggtgfgsehtqhhmtdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesnhhorhhmrghlrdiiohhnvgeqnecuggftrfgrthhtvghrnhepvd
    fhffehiefgjeefgeegvdejhfejhfevieeiudelgfeuieetffdvtedvuedvkeefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hnohhrmhgrlhdriihonhgvpdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtoh
    hmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdp
    rhgtphhtthhopegurghvihgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihgrmh
    drhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehs
    uhhsvgdrtgiipdhrtghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehsuhhrvghnsgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhhhohgtkhhosehs
    uhhsvgdrtghomhdprhgtphhtthhopehshhgrkhgvvghlrdgsuhhttheslhhinhhugidrug
    gvvh
X-ME-Proxy: <xmx:h6Nqaa9w6UYiI1ZIjUYzqwCSdTY8c9xxm8q_NF3woFiTKY_1q6hNCg>
    <xmx:h6NqafvRG9YRnbZjo598ejB-ABxCk5ZKRh1W02dGoZneqBSQ5PVAnA>
    <xmx:h6NqaQ6xUIFPlO6ZEJpEJRudiZfOHB5_rvCFO0ODvTOkygsfTdNWuw>
    <xmx:h6NqaYM6FMBx_lol5hidKvzPMzTQzYhNk1YZK54OLb4LEAJT11VEvg>
    <xmx:iaNqaWXCIF0d9tPUnNdvsTiEGS6kEVPoiMBGySDlNv533ItGc0TgeDfs>
Feedback-ID: i2b794257:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 15:45:56 -0500 (EST)
From: Zi Yan <zi.yan@normal.zone>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RESEND 3/3] mm: add + use vma_is_stabilised(),
 vma_assert_stabilised() helpers
Date: Fri, 16 Jan 2026 15:45:53 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <2859A1AD-E37A-4575-B217-AF233F7A99A5@normal.zone>
In-Reply-To: <87b36e11c632fee6c965b944974d8dc4357b5904.1768569863.git.lorenzo.stoakes@oracle.com>
References: <cover.1768569863.git.lorenzo.stoakes@oracle.com>
 <87b36e11c632fee6c965b944974d8dc4357b5904.1768569863.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 16 Jan 2026, at 8:36, Lorenzo Stoakes wrote:

> Sometimes we wish to assert that a VMA is stable, that is - the VMA can=
not
> be changed underneath us. This will be the case if EITHER the VMA lock =
or
> the mmap lock is held.
>
> In order to be able to do so this patch adds a vma_is_stabilised()
> predicate.
>
> We specify this differently based on whether CONFIG_PER_VMA_LOCK is
> specified - if it is then naturally we check both whether a VMA lock is=

> held or an mmap lock held, otherwise we need only check the mmap lock.
>
> Note that we only trigger the assert is CONFIG_DEBUG_VM is set, as havi=
ng
> this lock unset would indicate a programmatic error, so a release kerne=
l
> runtime assert doesn't make much sense.
>
> There are a couple places in the kernel where we already do this check =
-
> the anon_vma_name() helper in mm/madvise.c and vma_flag_set_atomic() in=

> include/linux/mm.h, which we update to use vma_assert_stabilised().
>
> These were in fact implemented incorrectly - if neither the mmap lock n=
or
> the VMA lock were held, these asserts did not fire.
>
> However since these asserts are debug-only, and a large number of test
> configurations will have CONFIG_PER_VMA_LOCK set, it has likely had no
> real-world impact.
>
> This change corrects this mistake at any rate.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/mm.h        |  4 +---
>  include/linux/mmap_lock.h | 23 ++++++++++++++++++++++-
>  mm/madvise.c              |  4 +---
>  3 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 44a2a9c0a92f..8707059f4d37 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1008,9 +1008,7 @@ static inline void vma_flag_set_atomic(struct vm_=
area_struct *vma,
>  {
>  	unsigned long *bitmap =3D ACCESS_PRIVATE(&vma->flags, __vma_flags);
>
> -	/* mmap read lock/VMA read lock must be held. */
> -	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))

Ideally, this should have been converted to use mmap_is_locked(vma->vm_mm=
)
in Patch 2. But this is a bug fix here, so that churn is not necessary.

> -		vma_assert_locked(vma);
> +	vma_assert_stabilised(vma);
>
>  	if (__vma_flag_atomic_valid(vma, bit))
>  		set_bit((__force int)bit, bitmap);
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 9f6932ffaaa0..711885cb5372 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -66,7 +66,6 @@ static inline void __mmap_lock_trace_released(struct =
mm_struct *mm, bool write)
>
>  #endif /* CONFIG_TRACING */
>
> -
>  static inline bool mmap_lock_is_contended(struct mm_struct *mm)
>  {
>  	return rwsem_is_contended(&mm->mmap_lock);
> @@ -272,6 +271,11 @@ static inline bool vma_is_locked(struct vm_area_st=
ruct *vma)
>  	return vma_is_read_locked(vma) || vma_is_write_locked(vma);
>  }
>
> +static inline bool vma_is_stabilised(struct vm_area_struct *vma)
> +{
> +	return vma_is_locked(vma) || mmap_is_locked(vma->vm_mm);
> +}
> +
>  static inline void vma_assert_write_locked(struct vm_area_struct *vma)=

>  {
>  	VM_BUG_ON_VMA(!vma_is_write_locked(vma), vma);
> @@ -358,6 +362,11 @@ static inline struct vm_area_struct *lock_vma_unde=
r_rcu(struct mm_struct *mm,
>  	return NULL;
>  }
>
> +static inline bool vma_is_stabilised(struct vm_area_struct *vma)
> +{
> +	return mmap_is_locked(vma->vm_mm);
> +}
> +
>  static inline void vma_assert_locked(struct vm_area_struct *vma)
>  {
>  	mmap_assert_locked(vma->vm_mm);
> @@ -463,4 +472,16 @@ static inline void mmap_read_unlock_non_owner(stru=
ct mm_struct *mm)
>  	up_read_non_owner(&mm->mmap_lock);
>  }
>
> +/**
> + * vma_assert_stabilised() - assert that this VMA cannot be changed fr=
om
> + * underneath us either by having a VMA or mmap lock held.
> + * @vma: The VMA whose stability we wish to assess.
> + *
> + * Note that this will only trigger an assert if CONFIG_DEBUG_VM is se=
t.
> + */
> +static inline void vma_assert_stabilised(struct vm_area_struct *vma)
> +{
> +	VM_BUG_ON_VMA(!vma_is_stabilised(vma), vma);
> +}
> +
>  #endif /* _LINUX_MMAP_LOCK_H */
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 4bf4c8c38fd3..1f3040688f04 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -109,9 +109,7 @@ void anon_vma_name_free(struct kref *kref)
>
>  struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
>  {
> -	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
> -		vma_assert_locked(vma);
> -
> +	vma_assert_stabilised(vma);
>  	return vma->anon_name;
>  }
>

LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>


Best Regards,
Yan, Zi
