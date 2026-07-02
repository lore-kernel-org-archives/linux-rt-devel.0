Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16753A874C;
	Thu,  2 Jul 2026 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988109; cv=none; b=ePJG2vWYNQui9ley9Yx7j8LFvz2hTTQB22dEd7E3x8F09VjV5SQRjObTZn/Q6lkWB8Vehn22vjQA/smitl3o0zCPWq6pNUpkkBBtOo96H0CHwSZt+f1KqG1NsXr5Bvl8ZITWTQnVfDB5MjZ+/pLgOe9ZyUd1uxzhI2DEKkFzA4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988109; c=relaxed/simple;
	bh=Ps6MN9vXXlPbbAn6Mx8RJK7lEpOhUVM+U7+MBRIqZfI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g5MUmSCGiD23nijUnEB12lRxpnvavR2HdrR9EamOmmdKtp2IxXTlzVs+RACaFn55L2F+gOdWeUsCKvUMA6QAxJjxU8VxNj99SF4fkaZV4N/mDz0YIPXi5B0KtbPEwxCTyi9sdX2bcUA+fEQhLIpdSsub6BmUQmzXhPHqVg4NxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlNTMFCv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlNTMFCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8651F000E9;
	Thu,  2 Jul 2026 10:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782988108;
	bh=A6kjF1SiiRCZN7vU27JilmHoaiW/oKSoRkUUixTi8+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SlNTMFCvYy7nIrJZ+b7FiPiCdxMByjfqoqeZbR7hLSWmjR1GmMmpKUg07O8gNRApH
	 vzvaD/WYrbWOpZshlUDWkgGKHQ5IKA8HXMc9DLNEGpo9QkTrXOn2NXHzuArmnX7K9L
	 rO753fXagvPDhwisStBdzFrJR318AnWUSWreDsdAhnC2bnd7MuHciP8rxDMfUjYBTw
	 v2je7n8NYfTzmosiBUEWrIZBpW23QbM4Ot0qJPBjY1FLTs8ZatOg2ZF9GloO+zJoFe
	 64hgDkouSPops3ojpV40z83g2jbk2AEFc9h/Pk093Bih5O8qqNO/Yi7Wbwj6xb/+q3
	 B6nFZ+Z8EVwTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/18] mm: move some stuff to mm/page_alloc.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260702-alloc-trylock-v4-7-0af8ff387e80@google.com>
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
 <20260702-alloc-trylock-v4-7-0af8ff387e80@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 10:28:27 +0000
Message-Id: <20260702102828.3C8651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Duplicate declaration of `drain_local_pages()` in `mm/page_alloc.h`=
 contradicts the commit message.
--

commit 54f4dc2300a55c6c9cef3e3916ba57e09ad07e39
Author: Brendan Jackman <jackmanb@google.com>

mm: move some stuff to mm/page_alloc.h

This commit shrinks the scope of several internal functions by moving their
declarations from the public include/linux/gfp.h header to the internal
mm/page_alloc.h header.

> diff --git a/mm/page_alloc.h b/mm/page_alloc.h
> index a4f4b325381ad..6bb50bae3ba27 100644
> --- a/mm/page_alloc.h
> +++ b/mm/page_alloc.h

[ ... ]

> @@ -266,6 +266,34 @@ static inline bool free_area_empty(struct free_area =
*area, int migratetype)
>  	return list_empty(&area->free_list[migratetype]);
>  }
> =20
> +/* Convert GFP flags to their corresponding migrate type */
> +#define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)

[ ... ]

> +bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
> +void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
> +void drain_all_pages(struct zone *zone);
> +void drain_local_pages(struct zone *zone);

[Severity: Low]
The commit message notes that drain_local_pages() is still used externally
and needs to stay behind in include/linux/gfp.h. Since it was successfully
left in the public header, is this declaration in mm/page_alloc.h an
accidental duplicate?

> +
> +void page_alloc_init_cpuhp(void);
>  void page_alloc_sysctl_init(void);
> =20
>  #endif /* __MM_PAGE_ALLOC_H */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-alloc-tryl=
ock-v4-0-0af8ff387e80@google.com?part=3D7
