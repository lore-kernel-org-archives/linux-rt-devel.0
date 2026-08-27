Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B023DCDBF
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 23:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873482; cv=none; b=GqsHK6hrSCO/JfHUf2rSBoRItTt375/3wwvBk197cCfvsKoJPQM3jEP1qrwMh805newyAyxEiHgUyMTZFldu65o7IaXDv1peoiuFsH/Qfmwz1ih7SF5BFSO7+h/ZgH6ph7n4+igeqR9vNcEUH12nRJKUTkxqkWdp5znKfgVRy6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873482; c=relaxed/simple;
	bh=1JDl/PiJOAZxnlSKEC5PiAyofjmTisyMsK4a9y30L6I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hGUeVqUam3QV7qJfB+J77+vmcSuO+8nQAhOc3akHCCfs7Kgvxq0yzimcChOoUbYmqoigvQjkMsofIMv5GhHZo27SEAwoQZN2zTYnhO1JvOpH4+4w4fQqLoITil13Z8s6GBmLA4mG1tiN0b2Hv6ecuxHZagz6hY5XhkQqqgcxtUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ikd2pwC0; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ikd2pwC0"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e25e4b41cso481624a91.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 16:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787873480; x=1788478280; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4pKguOeL4XpEhj7eOn7cPoRPiZ6Kih53q6MwTo24ARI=;
        b=Ikd2pwC0F98+gY7ggb7CN23ZGAkzJuctmky8YtFmj1ZKunKHrnjixPHspWeeuhBdce
         eiBCoOzHuqvUJvgT47ckKw8PBWJgcdI04mkN8P/DgVQn7MWuTumwp5I8vPBJqT80K4ei
         qubc8pJIrX3/8pyT3UlrP9J3QGxNdD13uaag8IgP+mdkEeagyFPd/gSvitMvnPEDxNmL
         XUS39kP+VUZ3qKaVdLilRxvuyqVLJ5YqtoJTp6N6zc+nVBjKI486IcoFBljWY3seATb3
         GQ+cmjCMclUQgPtVIFEUyIUVb2RE0RnXjxbaOfVQHmMJ+mMZ9lNywrhO+qH41PNooMqh
         cmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787873480; x=1788478280;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4pKguOeL4XpEhj7eOn7cPoRPiZ6Kih53q6MwTo24ARI=;
        b=VzwgW8/yKL5jua9o6+qWDhBdFYwbQ89yj3PNdUhMf0LV0k64bVIKm1+SEX5Fhisb4f
         Y829zWIfFEpEc5Eg+3ZZnCAM2qjHfK6IYctDEemUSKwkoiXOiuqKNyw5ZKAK8zq6nCAz
         JzNT50MfffyxnlpiAZd2fVKUREOQ2voK5lxp01b/4RTetggGB56ASbTCuPD2DD0XRE6w
         FZxj1PIh5W4aeovIMJ+uqq98cwFdnlGNJe8yPOVWlzCNUve28ezGtLleDPfbIpbzajzb
         ykca4CHRf7sdhJ0SEaMyAsg+H1HhNoLfCSMf/YM0p5zS+qbQFf7mpywPHOFeJ31gJCv5
         VhqA==
X-Forwarded-Encrypted: i=1; AHgh+RoWtDT5dqZMH1O/34paRelRhTuEpLtpp/NfGiaEJnVdpf4WxIqkYThLy6IOc+pyPH13+5+klVEbxazN54vuJg==@lists.linux.dev
X-Gm-Message-State: AFuF++lrEY7qAJZJmXZMrT5kTIkHcQtI+ypEduFxsEr7IdH+dgjTrjJl
	0F3YXZyBHgbZiYvfqFBJmsAdOUAZEC3NQpi5LkdyyvhKAvf2MdYXifVC5YauEW9tpMAM7Bm44cG
	Sh/+UDbi6bLwfZA==
X-Received: from dlbtp4.prod.google.com ([2002:a05:7022:3b84:b0:141:4abc:f12d])
 (user=stevensd job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1a8e:b0:396:4c63:7193 with SMTP id 98e67ed59e1d1-396d0fe45damr5091530a91.11.1787873480154;
 Thu, 27 Aug 2026 16:31:20 -0700 (PDT)
Date: Thu, 27 Aug 2026 16:29:40 -0700
In-Reply-To: <20260827232948.2520558-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260827232948.2520558-1-stevensd@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260827232948.2520558-3-stevensd@google.com>
Subject: [RFC 02/10] mm/vmalloc: Skip vmallocinfo NUMA stats for VM_SPARSE
From: David Stevens <stevensd@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Uladzislau Rezki <urezki@gmail.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, suleiman@google.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, 
	David Stevens <stevensd@google.com>
Content-Type: text/plain; charset="UTF-8"

Bail from show_numa_info() in vmalloc_info_show() for areas with
VM_SPARSE set. This lets clients that allocate VM_SPARSE areas directly
use vm_struct's nr_pages and pages fields.

Signed-off-by: David Stevens <stevensd@google.com>
---
 mm/vmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f4fa227a8d7f..d39897300f29 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -5294,6 +5294,9 @@ static void show_numa_info(struct seq_file *m, struct vm_struct *v,
 	if (!counters)
 		return;
 
+	if (v->flags & VM_SPARSE)
+		return;
+
 	memset(counters, 0, nr_node_ids * sizeof(unsigned int));
 
 	for (nr = 0; nr < v->nr_pages; nr += step)
-- 
2.55.0.897.gb25b4bd76c-goog

