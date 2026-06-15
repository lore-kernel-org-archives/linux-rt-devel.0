Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B793C5536
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Jun 2026 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512102; cv=none; b=Sj39RHswt4erPi0xev0E5kmMNS+uYPuWuoCHJNug1PSa3IRbe+QN4EJy8AiRcVTyLaRQNg2KYDFn21eM8AFJaq2OUG7qTVVB4lKXsGUEn8cGZbKT1x4mleTVE9JMZ07UdFtd5p/llPoGwqBKILBoHl7Ydkbgr9NjB2uhzmBDYnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512102; c=relaxed/simple;
	bh=pUPLBCg8NrCsW7Svk0ZQ40eOxjlfopfppmuFtnwA1h8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jjEgcReNApkxWdQiKVXaM9D4oqlhUAhVlpN3+1nqsiFNYGouZ2+R2D4+iHnVjJNutJXcRPhxZfBlYKwD4fNXXN5so7+g1IZjCeWSYscJqYLQ+jcB+ijTAd17aBJIqwguM+Y9EZt6+N9IiDjGCst5t2s0N67YnuARinOAZI7BE04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YORM1U7H; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YORM1U7H"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2c0c2c7e0c5so18977335ad.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Jun 2026 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781512098; x=1782116898; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OIK6+R0N6S5FbjNUFVY3i/UoNEgCH6Sdv2/saOFAeXs=;
        b=YORM1U7Hrm7287worbBnnzGYefDMPOouO8lQSr/65SiPSVfrZdnlYdj/mwAR4peTuQ
         RZBXojoJmnkFq9AifFRAitpM7zdxlBYqLuuAeYhvBDEScdfcCigPbBQSES0LNOQ9axdn
         bn1u8cZvJZKpzT2VaGrjAUGP+7VnZxVljFKpBjHNR3oVH/50UoA9GLqcFXJBr5s9O/8Z
         P3coFLwR1WTEJUeM9gTc2eY/GAXOYECxbBW3+mcua0ygp2aosyzivvnlpD+ovC+bSzaG
         ZaNcxynRsl0KPgLa78b6on3E8UFRLl64ynx0gHZXxyw0N0MBQBEJak1AMeliu1aeix/u
         5yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781512098; x=1782116898;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIK6+R0N6S5FbjNUFVY3i/UoNEgCH6Sdv2/saOFAeXs=;
        b=SH+9apDv4C4RmpgH0BDZJ2fESt+abtWQSpubydWJ5mRFvk9ZCkXtKFweENpOkfy3mm
         dl5iUL5tMU2gDlv8OA5Ek6uPH/2+hxihf8SxM2Q966Mb7eqnxExwkcn//OsDj4Q0w9FA
         dGHIFqzdK3gFrpYtEFkkXNs4PwtnA7vt4+XqJhdNY7i9qzV3DDf9BgT/kyig9Qh/LpJV
         /b2httf3DlhjpzySFXOuuWyVzDjafcBhl+Rk9XIMKLw4P4uwC/yAmZ7zIr2CPbYRWnlt
         VC+UnVmTkYOGtHMOWqrcB0dMsUYoOvojzXzfp2abuT7wdPvgdA8dAqRk4fxBRFqEAzpx
         3MwA==
X-Forwarded-Encrypted: i=1; AFNElJ8pqnATlhqZhaVvO5JJ5dZVPT0eYFYDBlgN0LXnIJdjiJaA+OO+4iXlXd2Guc2r1j1eGLIWVjex7dXEZfCG6g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yygtrb/JEuCaEEoXxOzjmvP5T1meULSTBIrXnuPfj1/X7sMlpc7
	kKIwGAm7bjZJ6adeUR1MSm3U88d94xswGL99LsyPqoOtfxUEQmqhaY6F
X-Gm-Gg: Acq92OHkuTuc+4wKdrZT6npGDcTM1qtqJz4kDT/RIZu2sOJFttqhpI900GlECCAohAv
	ETbGOYrPAQ4QWw6PAQgdzSOZs6GMyaE7KrqYqC1ybI3azg1DyZD0+P+/eMNLNetsxMJ7h4S9rGl
	HLdDYGhi4lQPeGGrW7RmKplw14j4N3ZW5lE7fWoAWhv75lSzTsjFOyzwGuZRlzMvuC9NN8UvBRR
	XZ59prYkYKnwvNLkKN5u2vZJ30hFy7Nq3PjiBjIY+tpR1pf9C9KMaPtYuciPwrKehOmYkdT5h1l
	7jiSQdxCaDkBsTTZVUPRWitKsMVoQJgFIvdkvdntxUKwLvhotPQ2OTGlNsrKppVVmSZ5cvlncIe
	LA3pIyegJFDYYYdE6ROSb61w9h1vJEuivRtfNBm60kiK1tpaZZX352l7NNriaLt3YbNQqbzO2Kd
	YzC34CR0+0OzaRwhOXNhfcuyE70dbwuho=
X-Received: by 2002:a17:903:2408:b0:2bf:1cda:29ce with SMTP id d9443c01a7336-2c4104117eamr138814175ad.6.1781512097656;
        Mon, 15 Jun 2026 01:28:17 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f2e52b5sm94136475ad.7.2026.06.15.01.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 01:28:16 -0700 (PDT)
Message-ID: <5d3d16f6-0654-483b-9625-94ab93d3d836@gmail.com>
Date: Mon, 15 Jun 2026 16:28:07 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] mm/compaction: honour compact_unevictable_allowed
 in mlock race and alloc_contig path
From: Wandun <chenwandun1@gmail.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 vbabka@kernel.org, bigeasy@linutronix.de, rostedt@goodmis.org,
 hughd@google.com
Cc: akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@kernel.org,
 ljs@kernel.org, liam@infradead.org, rppt@kernel.org, clrkwllms@kernel.org,
 Alexander.Krabler@kuka.com
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
Content-Language: en-US
In-Reply-To: <20260604023812.3700316-1-chenwandun1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/26 10:38, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> vm.compact_unevictable_allowed=0 is meant to keep compaction from
> touching unevictable folios. In practice there are still two paths
> where it does not take effect. This series fixes them and adds a
> tracepoint to make such issues easier to diagnose in the future.

Gentle ping, any feedback on this series?

Sashiko found a potential compilation error in patch2, I'll address
that along with any review comments in v2.

Best regards,
Wandun

> 
> Wandun Chen (3):
>   mm/compaction: skip isolate mlocked folios when
>     compact_unevictable_allowed=0
>   mm/compaction: add per-folio isolation tracepoint
>   mm/compaction: respect compact_unevictable_allowed in alloc_contig
>     path
> 
>  include/linux/compaction.h        |  6 ++++++
>  include/trace/events/compaction.h | 26 ++++++++++++++++++++++++++
>  mm/compaction.c                   | 14 +++++++++++---
>  mm/internal.h                     |  1 +
>  mm/page_alloc.c                   |  2 ++
>  5 files changed, 46 insertions(+), 3 deletions(-)
> 

