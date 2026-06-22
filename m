Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7878231830
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782169463; cv=none; b=Nos63na2Ttujr6SlSLxQfoTNo+8sI95GCNev8aNeuLju45a5xet871Ft2DajbL4QWWrEY0m4OJ28IZW/W1JtROT/8Wq6AWL9Z0x0qYNPbja0i+QQ5QbKRub3xmCinpma+WnlrTkEVjYpQBkuZOWlbotieIeVyTwSXEYkHXOc26w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782169463; c=relaxed/simple;
	bh=Jmd4nVp4kfTrvTVEijkTHHv51r48Mo7H+ZvtGBWl2O0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p8RX+kqrLDnS+ANtHH2VLTbxJQKnAMAf+iJLy2g9IzyGw7FRXG/qHdoR63tXr9mhD21NutrQ/z659sZJ1+m5IDlUAKPrx35uxFPI+EWq3n0OmvRuMg/JuhcjOH921glnS1IQKpF3xd0aINAWJRs6UDoKbr6p76BFdJmlrJ9fJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YunY5VEH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YunY5VEH"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c7403e80b0so42275245ad.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 16:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782169461; x=1782774261; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DbguCPrep9cl5dKCDjv+7UBnuf7b6qWOrC/gr5Xvvj8=;
        b=YunY5VEHeKmzTvthFDv8hv9uzNRb34x+yLQA+xxWL5Lb9o5ZceRQOFDHgT5R625R3e
         42I1GZs/CD6pJrNco6gNRmiIxiVHDN2RakBpXKFc6mdDa+olBVuS1Qkdct6aKdxZ3LLz
         /chNIEdIJKJUf9butYBTDU8GyMyjXsEdHATWlgQuLuVwjFCh9jAevTR7MxMSDr6uJJwG
         bPQpubdZaz3zOIPGJsit5gib5cL4UyYEXW9Q1Xb+PJRsd3S3/gtmmXFqyiEuwYl7rlQ7
         0YLFCpJeBN6nVm6aEd8eD23huBQ1bPZAoXKbSRNIFJjIDkcruvRyGCAPkI6cV4nvkiIx
         RfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782169461; x=1782774261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbguCPrep9cl5dKCDjv+7UBnuf7b6qWOrC/gr5Xvvj8=;
        b=Jk3ygoeMurQjawzdHtZkde5BPjTCYYaCKYTRDTunBSHQJVY1UxaPtWtxtlkFnyfeUt
         cjKCGC1rpf30S8R6zGnH5ew7INRaXCsTqXAGWco/n+MVpmpc8GTedHuTYpPG18sMUdK9
         GROdhUYtE0Dbyp/XdKJ2S84cTzaNuzvMO/RMAgcKgkEDZJQk5SAMkDUIBRG4XQEoI/hE
         HE9EJA9fxyAEZ/JvAePoWOilUmVs5j20tf65IdxOrLcaR9ZIHhhFxIlJiYF7hoIdEz/g
         MYDcZwmPadjqtuvl1ZOS/LFYMukrEDY+5QEUWAF7crWYO5+nWqCAIwLI/wEYTtJqTBA8
         qLmg==
X-Forwarded-Encrypted: i=1; AHgh+RogAH8zeAIezryEcdDg8KcCihfDhwDS2f5iU/CoJvp18ZQZjLHf66apvNtRaLJQBTkR6woUj06s963iMaF7+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxFjawNApGyWkkiakQf5jtazBXAmJnpThNVwdDnYedNsR6mmi+
	hz9lwd9GPorLoH8Wn2CalwQH+vE37t6Gh+uJpzbgAstrMEED/j5g+A7hdy9uh5wqaomsTuzO5e0
	Ck31BPg==
X-Received: from plpm7.prod.google.com ([2002:a17:903:3de7:b0:2c6:9f4f:f3b8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8cd:b0:2b4:656b:aeb0
 with SMTP id d9443c01a7336-2c718f67cfbmr186053355ad.35.1782169460861; Mon, 22
 Jun 2026 16:04:20 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:04:20 -0700
In-Reply-To: <DJFI4P57YE9X.20DPMTK9LL7LW@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-6-31f31367d420@google.com> <20260622101056.4120C1F000E9@smtp.kernel.org>
 <DJFI4P57YE9X.20DPMTK9LL7LW@linux.dev>
Message-ID: <ajm_dEqauYLBi-7T@google.com>
Subject: Re: [PATCH v2 06/13] KVM: VMX: Use higher-level allocator
From: Sean Christopherson <seanjc@google.com>
To: Brendan Jackman <brendan.jackman@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, Brendan Jackman <jackmanb@google.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 22, 2026, Brendan Jackman wrote:
> On Mon Jun 22, 2026 at 10:10 AM UTC, sashiko-bot wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] The commit message incorrectly states that `__alloc_pages_node()` allows passing `NUMA_NO_NODE`, while the opposite is true.
> > --
> >
> > commit 7bd439c242125db27305b61b14c9972fb028282a
> > Author: Brendan Jackman <jackmanb@google.com>
> >
> > KVM: VMX: Use higher-level allocator

While you're dealing with nits, can you massage the shortlog to something like:

  KVM: VMX: Use no-underscores API when allocating pages for a specific NUMA node

"Use higher-level allocator" is extremely vague, and arguably misleading because
the "allocator" being used isn't changing.  Which is kinda the point: *nothing*
is changing in practice.
