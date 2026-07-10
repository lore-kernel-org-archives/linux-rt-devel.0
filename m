Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A296A3CC337
	for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680163; cv=none; b=P9E/yRcyncrUNFC9cKRlRB2enXKevRXdwsPePWabgvkuomng3epIxinGAIVSMrnX8CtEWFoDdEVDICb3ah8IiBhv9tAMLkus8W70zLcZl4vznOxyZvgUe779lWwuZUUE1j6cCicyBfYVdEXK1Kt7OrW0PrHewDyK2zGaVaPRX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680163; c=relaxed/simple;
	bh=UvP4r/8ewMUaNP1Qd8YFWvOIYOukjYVtZmQg7stOH5k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qJ6Bq9A4BWA+rF3/OXQbsCZj4pucBf0nkMmezCsn5VsMxl8+hdDjnvBffdJuLxejXN5o9OPNGCxZZd+lyld6buAQ1Zu2mBaSE4vv8/9YJGwoRnR4b+TpFamU0eBIsrop3iMsPxEZsMZ5Gcp8DKIxW7w7EbAc0du7LmeAa2An84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PYQq85AB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PYQq85AB"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493caa3c54eso6374835e9.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 03:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783680160; x=1784284960; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XVV0CZtE+jAiIp2jucN5t1l22tPDkrJA7DCQqcEcxvk=;
        b=PYQq85AB39Njt4ydQuoNe4dTK5FcmiBMevp5d+wi1g6bbq5jo7TpuBXpOjR0TtVs6f
         J5n+j9L2t2GYd3bDi9ZhyQSnbC1Te/HXyyfGl3cOLMP16xcsL/Qi94TXh5EEmHSHTrT6
         QCdFYs4iyUiXez3VJnOJn3q1Y9ZjbvQqqs5MdkXvdbVY0cqaK5JvM7mIFVSbj+mQFfwE
         yyC3Rwwzb2G3iAkz1MciawJHrefrEF5vEjVttCjLSIUqQlrktL9mEJdswa0GEU0LOl09
         ki9CTlXer0wS8QN9GNl7H7m1yQTEHWEtQMLQGq5van8VqmFT+72pEzRW+OOUF28PLvBk
         O2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783680160; x=1784284960;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XVV0CZtE+jAiIp2jucN5t1l22tPDkrJA7DCQqcEcxvk=;
        b=rq8hW3k2sfNL+vrUyLzBiGUkBmUTInaEpsLLxCJukaq8mwlnB3Y0dHI1IG4R4pQJbW
         im40TD5o7wmMDnDVj5jfqJVG1/qsvIzR3bEwfRafGGYGgaWbUs4FC5YTonBZG1SjJUOk
         vQqF030dm2JxVXiuoIUVTde7FUkUsInMZTeFnC9Aka1DWuuuUQKvvoU/3JiRWXeJ5SgN
         KIwJm1AnAJ11nm+sSHSVQ9aiHzgUZbKrTfK/qS5ds3KJ2MebjuYh90Nru180MtvccBqW
         BoK9KWaq8TG7P0t49sD4+C3VfyPodvpqD2ePqs7T2zcpvxLynry2oVSswROaNee0WkRC
         NbkA==
X-Forwarded-Encrypted: i=1; AHgh+RojJ6LvFTeVNpeSC9W1UviKlDXPxZZDcpANYI9tMGY1E4TYiyKY6zNO+qO3KmbPQZ0+nht5mZSP3uOij9LX8g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1ajA8i/aC7HlQq8qGV8T7JXOiCE89c/7lHJBLpdLBQ30Ju/aD
	LA9wwYGamjm3pb/Sz8KjGS8aFneGrFYVqjVK/sWxA7Frh+qzMIZxG1lBTuQ7ug9bHAtnuqR00p2
	h6vO5oR0MXVrI2A==
X-Received: from wrse13.prod.google.com ([2002:adf:fc4d:0:b0:476:4ac9:27db])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6217:b0:493:e9c2:ba60 with SMTP id 5b1f17b1804b1-493ec7a7a26mr63789625e9.22.1783680159801;
 Fri, 10 Jul 2026 03:42:39 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:42:19 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIvMUGoC/yXMTQ6CMBBA4auQWTtJaZMSvIpxIWXQ0aZtOvyGc
 HerLL/FezsIZSaBa7VDppmFYyioLxW41yM8CbkvBq20VU2tUBIHHPPmo/vgEL2Py5TQGO2ssaT 6toXSpkwDr//v7X5apu5NbvzN4Di+0UfLwnkAAAA=
X-Change-Id: 20260710-spin-trylock-followup-332c636e0d99
X-Mailer: b4 0.15.2
Message-ID: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
Subject: [PATCH 0/2] mm/page_alloc: couple of followups for recent cleanups
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Harry Yoo <harry@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Brendan Jackman <jackmanb@google.com>, 
	sashiko-bot@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

These patches are technically orthogonal to each other I'm just sending
them as a series to avoid someone needing to deal with the (trivial)
conflicts.

Based on mm-new, depends on
https://lore.kernel.org/all/20260703-alloc-trylock-v5-0-c87b714e19d3@google.com/

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Brendan Jackman (2):
      mm/page_alloc: don't spin_trylock() in NMI on UP
      mm/page_alloc: rename FPI_TRYLOCK -> FPI_NOLOCK

 mm/page_alloc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)
---
base-commit: 9d6a99520ac667ab6c1dbed364169b68d38f1a5c
change-id: 20260710-spin-trylock-followup-332c636e0d99

Best regards,
--  
Brendan Jackman <jackmanb@google.com>

