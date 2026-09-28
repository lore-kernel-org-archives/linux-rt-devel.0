Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626E14F3EB6
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617323; cv=none; b=IH/OPOUHICcdzsmi4cLgsN31mGQ303H5xYp+DeYNKnQN7OF6yCARUjyWv8xCkjbz5HLtaWhiLbarBGCCcv99rZE9uYeuFVV1hAURYtBqIqOq2/TeSy5tauv5730KFOFpc+kncF+1rvI03fws6PakFORlEVRF9/TGaHHGFYBkpAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617323; c=relaxed/simple;
	bh=ociixwuu60tID8XiJyfQ7GPM3G87cit0sEXbMZxlYyk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HTAwebRnFfcqVAbzW0shYWL/SeUkbkXGL610Ly5FRHdkcxxvyZhwx9RyQCW0Kwz4jrvsekwsTL+dsuut93Iugq4KnueStBjqj3oc8WX50LYrTqy18A1u4jU0QtI8LDNeEe24omYavNN2vIEsEV4DZE87IXFT97BP0n2qeCZ3HPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YxtCd0L1; arc=none smtp.client-ip=209.85.221.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YxtCd0L1"
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48aef5cfe43so121895f8f.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617317; x=1791222117; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+/9CJBbG35x+y3Ddsn+TP4ZxkCLdkVf/5InNQKQpJMA=;
        b=YxtCd0L1+XmelEZRwDnBEJHQae93VGswgL9F1YFgALrPM4/gh8+DsOFBavSQkwNCrR
         xrUdVPhENujywC54XiLD5ByEe2dTbsxA4WF/Znc+bJAvD1lg2hC1bwAHmGMj3+TGB1v+
         aY+u3vEoj5Jvfp8B9lC5IfavhFKj7q2Ret4aJghu6ag7e0I+90Pdswrq/lg2/C28Tfex
         HTQsIq2nXIn2TiDZ6YqKS1PDNWJ0NgURvrabn0MhpND+YoGhslrpdHzOFV2FU1/vr1sg
         1pblb1HEucgaWtIdBgj1z3ycf0Isg597guPaOkpVQmQGY6zbTe+N/h3EHU+BwkU9EQTE
         YlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617317; x=1791222117;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+/9CJBbG35x+y3Ddsn+TP4ZxkCLdkVf/5InNQKQpJMA=;
        b=wFlLPblhrC3k9bfCrQJ5kCdVuQT2Yel3f2ub+5t5NspZiLjSZSuXeit/aHZJQ3uoAL
         x4Nn8/Yws0fHXQ6uUV1DwkPez42C3iUmu65RUubASslOR5Oe/x1PZHu/uFeAgNCqwuyq
         ZbaxyIEf5R4Bn5icvtJF9q0edntlrbm1JQD0tAFSCFq4r5herw/Mjag6TVK7d1kxVm/g
         xnSycbE2QDwncuiT+oeDXVIII+MMyfTFacUmgFxiDcg+NVWLWepOabULlzfLivhR92lk
         VuAZMz5dS35ZQIsRzKes+S0knL8SIe0oq3fAVf94MhmMlA8nyLu5Qqyttd6Qu4y241kF
         /1DA==
X-Forwarded-Encrypted: i=1; AKwUvBy1Kx9n84pSwg0T6ruLS1wXaOHbsk83sDWUn9eNu2cX2a0W6J91tl+OgTiOw1WOEJv2neJQ6zA6jwiguAvr2g==@lists.linux.dev
X-Gm-Message-State: AFq9FYJk3M1URzbiwR+fah4NrOQJuDAnkQ60/NW8uPBTnkHIMpI5EegF
	LuvpvO8pdDhJ10dXf7z6NGzm3c71EB7+sCDrld0gTM18g4/fGuQmJevoByXUcFXloIPhr6Tct9S
	8VmOm4WROWRCg7A==
X-Received: from wrck15.prod.google.com ([2002:a5d:524f:0:b0:489:bd7b:5942])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2010:b0:488:7803:c1ef with SMTP id ffacd0b85a97d-4887db496acmr19692502f8f.48.1790617316679;
 Mon, 28 Sep 2026 10:41:56 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:15 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-9-smostafa@google.com>
Subject: [RFC PATCH 08/15] mm: kmemleak: Don't assume the kernel stack size
From: Mostafa Saleh <smostafa@google.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	akpm@linux-foundation.org, urezki@gmail.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, kees@kernel.org, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, gustavoars@kernel.org, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

kmemleak_scan_task_stacks() assumes that the kernel stack size is
THREAD_SIZE.
The allocated kernel stack size may not be THREAD_SIZE anymore, rely
on the newly introduced helpers task_stack_{low, high}()

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 mm/kmemleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 8fa409a4f9fb..72e2c628a20b 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1749,7 +1749,7 @@ static void kmemleak_scan_task_stacks(void)
 			void *stack = try_get_task_stack(p);
 
 			if (stack) {
-				stop = scan_block(stack, stack + THREAD_SIZE, NULL);
+				stop = scan_block(task_stack_low(p), task_stack_high(p), NULL);
 				put_task_stack(p);
 			}
 			put_task_struct(p);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

