Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90E131B10D
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Dec 2025 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765790546; cv=none; b=oFgKwmY6rIrMBlnbagY06B8jeUZ6vXWfNp+BHD8mgY2VqvHuImVOvb/qayArCZ0Zq0tqstfvdCdK2tibM5MyKlGzPnpS/c4jNghe6tH8Ixeaz3A1blQfqTKfvvqyrLtuomf+2Xa1mHks3nqE7Trijq1ntCSwfc16Jta2eIYHrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765790546; c=relaxed/simple;
	bh=rRgk/jKyq3Xc+z294BSrYdB5EGZbteu2gYXGFcGqquw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HbHgS3Kcj2sOa7lmRxV2zcVIQ+iaMDymuhJwOWNmfiwSPOkHShLqv5NC1nYX4g931fVWRu2CFnWOg6/DOKyf3Zx6DKA5OFnojXSgXEBLj4nxJiADl512xjbUt8EteLAxF7LfRUyRtlAqD1eULZxLMZGWZLXjfIVt9ruhmYkSMbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cTx8KSx7; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cTx8KSx7"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-649839c5653so4946822a12.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Dec 2025 01:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765790543; x=1766395343; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rRgk/jKyq3Xc+z294BSrYdB5EGZbteu2gYXGFcGqquw=;
        b=cTx8KSx7EpSLu3CLfyjVG1AZq4+yd/10oT2rcTIBI5MPdJ6G9C1Qrcs9+m6NZAyD9i
         3QG7VEdew7k8prNWvMfKClxTmh6N0QzqrGW0Y2Tj0mjEGn3LkJF54gg8c0jZLEXNf0eL
         LdrDjz6bFvyrF6WYrf9eLvp6obNVvwf2x8M9NQyM3LUfmlnMUig1uIcq2tj2dLN1dyor
         ca5ntMDLSDg9J/2VCPAOpoW+e2XHXMrUMJTtvgUqnNdcKOUBbCCBkkU0O9om01CavHZB
         r/m+AeuINkF9GxTKRMrPPq5YI2yOkWvglJ6DHzwCrwUinUj8fRKmuhAJtTBwRiGs8O1H
         GnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765790543; x=1766395343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRgk/jKyq3Xc+z294BSrYdB5EGZbteu2gYXGFcGqquw=;
        b=iqPjPrdcEbpFxcND52r/KVKnXU5krMx6jS8smHUUC/NfqkcBBuC2wDruq/iE1+qERR
         zd5Uh7hSYzx3nyjdfDSOy5dLrgM1gIQlvHFskNZWDIHX1K+WItwAHptIPjwHkhyKSfn6
         jvdDb0M1sKFHC61V0gFYeSUT2ar2y7Yp8EF2d17vLHkMGzSaPHFTHRMaUh9gXwPDViFQ
         Je9sXeQX7eKfr5SUmDTOVYh8nBLXXQXj/lYrQynZdIsrc4M4W0AsJpEFhh/axZrm+RJO
         A4UingQhq6Be5hwFJ0TSjuZSJr4WD9sODW4dWs3r1mnVdRR3BdNk7Zuxg2FAbpSwwV3V
         qXNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3Yr9Uy0HlKbSJ5qzjLn90cF78u2vKVwc42c4CsWsGDV5q+S3G607iO8hqTsmgusIy172SSlA1l5DUFYLz6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIGtfD1TH/rykKtqxxB9JaPluxdzQ3EoUfltf3harojEQqR65z
	C1LVIOrhivH+8motDK7Qg8p7qP1oJxU+yNnpSywTqBNTgLPvgNZ6yI5nozcw8q6ELLA28RTiYWz
	a4u5jtI+RoBuItg==
X-Google-Smtp-Source: AGHT+IGqA6/7NhdOmRJlayZuRkq/89Snr/0cKuIgnNpYQ1catSJLJfZQNQG1cjXYcwltRqxHcaD6SGiYTjuK7g==
X-Received: from edbdy7.prod.google.com ([2002:a05:6402:31e7:b0:649:8456:d4bf])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4312:b0:649:62e1:10ca with SMTP id 4fb4d7f45d1cf-6499b1d86bfmr9525174a12.27.1765790543128;
 Mon, 15 Dec 2025 01:22:23 -0800 (PST)
Date: Mon, 15 Dec 2025 09:22:22 +0000
In-Reply-To: <aT5/y3cSGIzi2K+m@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251212161832.2067134-1-yeoreum.yun@arm.com> <20251212161832.2067134-3-yeoreum.yun@arm.com>
 <CA+i-1C2e7QNTy5u=HF7tLsLXLq4xYbMTCbNjWGAxHz4uwgR05g@mail.gmail.com> <aT5/y3cSGIzi2K+m@e129823.arm.com>
X-Mailer: aerc 0.21.0
Message-ID: <DEYOI8H2OESD.1H56D3H8HKILB@google.com>
Subject: Re: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while stop_machine()
From: Brendan Jackman <jackmanb@google.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, Brendan Jackman <jackmanb@google.com>
Cc: <akpm@linux-foundation.org>, <david@kernel.org>, 
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>, 
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <ast@kernel.org>, 
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>, 
	<eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>, 
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>, 
	<haoluo@google.com>, <jolsa@kernel.org>, <hannes@cmpxchg.org>, 
	<ziy@nvidia.com>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>, 
	<rostedt@goodmis.org>, <catalin.marinas@arm.com>, <will@kernel.org>, 
	<ryan.roberts@arm.com>, <kevin.brodsky@arm.com>, <dev.jain@arm.com>, 
	<yang@os.amperecomputing.com>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, 
	<linux-rt-devel@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sun Dec 14, 2025 at 9:13 AM UTC, Yeoreum Yun wrote:
>> I don't have the context on what this code is doing so take this with
>> a grain of salt, but...
>>
>> The point of the _nolock alloc is to give the allocator an excuse to
>> fail. Panicking on that failure doesn't seem like a great idea to me?
>
> I thought first whether it changes to "static" memory area to handle
> this in PREEMPT_RT.
> But since this function is called while smp_cpus_done().
> So, I think it's fine since there wouldn't be a contention for
> memory allocation in this phase.

Then shouldn't it use _nolock unconditionally?
