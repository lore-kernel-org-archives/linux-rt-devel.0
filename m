Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0F47206A
	for <linux-rt-devel@lists.linux.dev>; Fri,  9 Oct 2026 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529666; cv=none; b=czbXByu+wkhGriYzVi0DFy+InDFBZFygA2GRDNScSbJISLc56sSYUe3EuQFuSx4YW8EWhtKT65Y0A4CNRS9JgOwCVbakyNaJG7xuSJMgYnq/0hkPS03FPbOc0kIVWXOlmSoGnBDxMZPBfGfqESXhee4Ey5un0jzZDh94RPGN7fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529666; c=relaxed/simple;
	bh=AOBfyMObxsPKe5555MA7X0XhuhbKoT8tcSGCgf4g340=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj4bNZkS6kplieStn1vq53ZmDSBgXqcFD/uKoEj7BMGPPvOrZUSLKHqS4pGbwwCyS6pjdgdx7C5ZaKXxR1rQdpGJFoOvrS8tCEjed/zO3dLc5lA9POdj2rHKmJKqdGbx4j5+GVXPFAhI/vrxnVD/QshMU2N+WhytZYeMxTy4qhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SE3bYyIL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE3bYyIL"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso54364175e9.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 09 Oct 2026 00:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791529663; x=1792134463; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sKKm9SmEIl/bnNoeHMWb5gysBaP9kkRYpBJirexaJDo=;
        b=SE3bYyILGRQD52Yd6zof0F2bIj+0B/IF4YeTikgv8OBuCgAIoA6kM1Ngr23DBENKvM
         YOJMoHttQDrUiCFGo3wF3ee+q9llgH+jNcxy25s+Uu1R1yiCh5cf2sjQddXoKpJCEXQn
         zr4h7PSzLxtSLRJNh/qWS0pvrwfdZfkgIgGwvcxBN+ZZhGg4lgM2+sIBy2NTxmxpO168
         f9Rks1yAZAQ6kyq5ZixtE4fwPZd8oGKTkBeBDngda2W4xa+ObgU2nTPcgcpWoOCSUP+y
         ljJmcPC+v4agK30Sap9tj8ye9/K11BZt8j3DyQI9ynYX6EJaJdWAUlVMSWxSLdyj1cx9
         HAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791529663; x=1792134463;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sKKm9SmEIl/bnNoeHMWb5gysBaP9kkRYpBJirexaJDo=;
        b=CdotL5qRJGdjbxkrhaO+4HnLML6nk5xhiTfrn+JRsEfrAwitJOZBD7jAEGcjdHYjbW
         eBi0M55WpAucXy748HAWO1pDy4Jzj+Y7nSHrUnVwWS/UjrlfYE4eN4B/mLQ3gXpK5Afi
         dVSutIc0lz8YWZtVu3T5hhu1ISShBcarsyWN0eeZ3WEQCma+OnGDlv6Ga8GQDEIl828e
         07iuywRrrVFs9GSqNTClX4tsjYxDXMYgQKe3iq0LsIjutqhhEs83UQhTTmGlfwEGUu50
         eEtuyXlV6kxumeT1PokmdS6SUjBQqFn1cjcXy0hG0VM00lvlMGgp1Y4FLh3/sOz8dnnv
         pwcA==
X-Forwarded-Encrypted: i=1; AKwUvBz/geReGCySEsL7AcDVnGpMaKYdV0kOCRTlLcYwaZHDJcDOIJeG9Oj2p51ldv2mkJQl53zdEChDnRUEvNgOag==@lists.linux.dev
X-Gm-Message-State: AFuF++k8Lu/zKsv7aIYittdBE+rtD34U8WGDVW84jtPJCULKtxI75McR
	vAHKALxiyzasGIcHQW5ACJteFD5dlA1V1Z4G8Rhf6ZAlBlisavOGffhB
X-Gm-Gg: AYBFou2N+VRty7qGMy9B/PWHqSoXwYgkp8xEL5mFIx/OqAgwBjG36igZ7rph/7Ce2hB
	ACn7WvDAAjsWscxCtPhS0v1GYu0fVEDtXmVZsj0VD0jQcAjJSbmfsoUG1PV9WO8dAT9lGEnOmNB
	E++X4PTyRVOG1uz1366hbXoU6I4W59A1tVxE48JCU0rfvnU5VJtnFNKxp9OgZYth+g7RWcnNMHE
	X71A3KTXqD1xUbL7kaj8kkesV4bDfC4J5ufFHDYUSEc5kthwbgrDJDl+aBu0x3It3s8r45Pp60H
	/v4URnMQFbTRphnmXlao0CSGfdutiORDofYjLQqJxKMDx29VFxg5mNnrWLoVov6WDRVFFvkDXy2
	P6shiCkcoeEBghbgLa7z25ZMKGPE0gq0VEs7XSmKKXs8MvI4RiDQBkHR0O8l4gK3312jlP79W3X
	qUHBjVZ2KcVEJkjbG0elHU/uhlKjwGyyASzzjqu8NvxA3CD5qST1UtfYqnhtxy9zm7Ldm4y1omz
	gVDv4W2zyOVIdMKhdE+q+tXoN/qt7P1CRKEjAMnjIX9hR53HxcTLdq0q5yHsnd/rqHVZ9fRNg5o
	PdMqtk90J0iPZu9QFcJsj+wiKk2+BqB67U/yJmVK+FyiHPLvN7mMXQ+l/HXuFXsSVqmGL4ls7c2
	IJXc4iqr++Q==
X-Received: by 2002:a05:600c:8708:b0:4a1:7b05:3a6d with SMTP id 5b1f17b1804b1-4a18e49881amr14849175e9.8.1791529663117;
        Fri, 09 Oct 2026 00:07:43 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a128-aa01-297a-7094-853e-a20c.310.pool.telefonica.de. [2a02:3100:a128:aa01:297a:7094:853e:a20c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf2caf4sm41656205e9.10.2026.10.09.00.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 00:07:42 -0700 (PDT)
Date: Fri, 9 Oct 2026 09:07:41 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Harry Yoo <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] mm/slub: preserve no-lock freeing after memcg charge
 failure
Message-ID: <asiSUpAYYU8Od4HM@gmail.com>
References: <20261001044056.75079-1-kmehltretter@gmail.com>
 <20261001044056.75079-2-kmehltretter@gmail.com>
 <asaAwg1KeZoEYd4K@thinkpad>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asaAwg1KeZoEYd4K@thinkpad>

On Wed, Oct 07, 2026 at 07:40:17PM +0100, Harry Yoo wrote:
> > 
> > Use kfree_nolock() when the allocation flags disallow spinning.  This
> > keeps the SLUB object rollback on the no-lock free path.  The failed
> > allocation continues to return NULL.
> 
> When this happens, the object is not charged by memcg.
> 
> The kernel should not invoke memcg_slab_free_hook() (called by
> kfree_nolock()) for a slab object that is not charged by memcg.
> 

Agreed. I'll avoid the memcg free hook on charge abort.

One question: kfree_nolock() currently skips init_on_free, while the
existing charge-abort path honors it. Was that intentional? I couldn't
find it discussed in the introduction threads.

If kfree_nolock() should honor init_on_free, I'll include that fix as
the first patch in the revised series. The charge-abort fix will then
reuse the shared initialization helper.

Karl
