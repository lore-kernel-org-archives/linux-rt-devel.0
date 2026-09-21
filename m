Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1EF364059
	for <linux-rt-devel@lists.linux.dev>; Mon, 21 Sep 2026 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970428; cv=none; b=G/8XLP4P0xn05ArfoFZ9VDA8VIQxLWN3VxLomPa4n4IeZLwGhSrbuaeRUCK9E3ScYodOGzxpbYeHVGNlc4ZTwxuCJs0hEuiwsGCgMEc6Bh+a4BWOy7Tf4hLYHjhZLuKz5b+SpDgk0HT2RGGvedqpVWLJEAD5DSzRb5tuzG10/nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970428; c=relaxed/simple;
	bh=r4IZ5+oRt2NTHUYf5LXmNkSjOac+QeyqRjRNuHQhAo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EvbIDvz82kHz187W6EEUFlXL80YnP3XnMnaGmOUeSwLsFKlhL45apxuzUz2gQ1EWx6ppMxt+WjTg3X+Qba06spY7Dl7ZIdzFBXtV9PhzydaUtJ4UdQ4avmWoAyor2nnM/l6KDIL4fIfr8eoJ3FORtfSCW2939tUarILvY9rcaIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLaMkjah; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLaMkjah"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e2406so12578895e9.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 20 Sep 2026 23:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789970424; x=1790575224; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zqp0mXAPPlkB9y/VY2ECjAIS1J7bwOQJ/4A4XQOWjYI=;
        b=PLaMkjahe/TekP/q6qe3PEQcyGrfVBQKzEiJvofFuje5dua/pv7c89fVtVPKvPw9Gx
         WXgZ/XE+Ia+mPdtfn8Kr9gygve/lzF0OJZ1vg9+EmV1C9j0A1+kk29Z8WNuZ4reFU/Jp
         ucIB32RYAVVlLdcFrbFsk+8pbXR4CIddlkSh80o3yuRZNvgYTyAgMm2GGrhrDSZMC4Oj
         xGnt4EcBy26IGlsE7EfGvNbxmMqdh4LMmMNCSIhihqKfruSv/2wZfj3Ldljiyq4XfVL5
         /V2E/2qlE0l+P8AAQLB87yq8ZRA6f31JC9c2aaXqr2ocBQWBKJ621v26MAco7zM6BC3N
         exFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789970424; x=1790575224;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zqp0mXAPPlkB9y/VY2ECjAIS1J7bwOQJ/4A4XQOWjYI=;
        b=ILazGoBaMVz/ijKjCwPqz1BRKJjU4LrNT9QYOZCg5bC/vzyV5xIlylRyJKuP81tA7R
         V0cJUDdBfxcqAwqNmIKMOGrs+btcVV9PwXTYnr5D+UrKHx2S218HInuUdjNIWfkQunmb
         RCh6rVtW7E/IMO7BZmzkUtFGYffs4+IZmVK76wROmfOuWdZWgvZ7hWvHGpvCFYeomATZ
         V32kgj/9hxu0INkTsyaWtOfxK64qUDJ49tcL3SX7vKyiDFQw3+mrGyR7sztcLr++jabT
         MtUAcVuOXymL8ZJJnTf62Fxm76/ypbLs3x3NsVJlAgZywUTZqg4g+oyIQWhnUHJU9AdK
         4gFg==
X-Forwarded-Encrypted: i=1; AKwUvBy1cylR8aaHT+xV3iXJQfZ9g+RYnNld/hAZrtzdk92lcMlO/9uDZ3LYei4mg2U9Xm4N3jGWLUoQ4AQPuffFjA==@lists.linux.dev
X-Gm-Message-State: AFuF++mTXrKkh1gbcekQO/eV7yyd0Hfq1vblwnNrgr4d5XavNRpYOIBx
	Jdr3l/XYKyXlW229wtaWCEgor7sPe0QNJagJeQftSZ9f5+iELyeQ9tRU
X-Gm-Gg: AYBFou2UAm0AWjVdMstNkgXLBpcz1/7k7wxKU5ChiEhTGKVUPuwzCK58onfhBcpN6Sh
	ie+oCRn7Jb2+UlQr1Sg/eeiXJe/YckcV1NnS4zro4Yr245SHDjwx5vsfgasXZq15YO25hEgjALQ
	2gvjhI7TyNuo/ncHhIHCD78Vddkk3hReVTBj1nHO1eAKOMOQsnqItRCJRBsco36N7emXCpTPVOT
	wk37NM4vhbQw/P/JUc9+n95DA0eoUXLvkyTJKJW5kI8i5YSqpt31kDdhD7mpLxoOCWBzx5KBbwk
	Jq+JHTVDotfOXBl7ZIMubEQ3unqxPPVwOgBLOUIkIJakyp5vtV2oFcb2jX2+yAm9FTXRPguZFOi
	oJPDP0y1BAKveZHzMtP+/rN8xG0U9ZLcWP6vZiGsSueckdELBKdWyT2FP5WoMW4JeNYdEgkWoMt
	vgh7bw8fOvGAYeWeuBED3St+8z6danfmDusEusRZ6VBcqTOgkDkiqS1WaJRCUkQYjp9eveD92md
	OXxmL6XQqkHG/yBS03WTUDf3UHR3ouStTICRIykVgN2EaqHZNWBDG+LfHTJIkP8xeZuPV2B34J6
	YGPQrDBXF4mcee0c26lp3MkqQEbPppv0+W07nu65um/G71AHrmRylUCPlcs+g0iSOPe658hkRA=
	=
X-Received: by 2002:a05:600c:468a:b0:49e:7c8c:bc77 with SMTP id 5b1f17b1804b1-49fc4fae7acmr152289065e9.7.1789970423297;
        Sun, 20 Sep 2026 23:00:23 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8e9-c501-f941-243b-87f6-e5a2.310.pool.telefonica.de. [2a02:3100:a8e9:c501:f941:243b:87f6:e5a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd1149e0sm198706585e9.13.2026.09.20.23.00.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 23:00:22 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Radu Rendec <rrendec@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/4] ARM: allocate the cacheinfo early to fix the PREEMPT_RT boot warning
Date: Mon, 21 Sep 2026 08:00:09 +0200
Message-Id: <20260921-arm-cacheinfo-v2-5892c4531ad9-0@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAD++jL=7OSrPMax9GRj3D7ehjmmG2uMyws53F8U0x7YGx+RNOQ@mail.gmail.com>
References: <20260912195552.76673-1-kmehltretter@gmail.com> <CAD++jL=7OSrPMax9GRj3D7ehjmmG2uMyws53F8U0x7YGx+RNOQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves ARM cacheinfo allocation to the boot CPU to avoid
sleeping-lock warnings during PREEMPT_RT secondary-CPU startup. It is
rebased onto v7.3-rc1, cee9395acd8043be0644b25c34bfa86623f2b935.

Patches 1-3 prepare for early allocation: bound cache-leaf writes,
include external caches in the allocation size, and guard CLIDR reads
on older CPUs. Patch 4 enables early allocation. Please take all four
patches together for stable.

Changes in v2:
- Rebase from post-v7.3-rc2 mainline (5225b8eec4c9) onto v7.3-rc1
  as Linus requested [1].
- Add Sebastian's Tested-by and links to the original patch posts.
- Retest the full series on this base; results below.
The four code diffs are unchanged.

Fresh testing on this v7.3-rc1 base used GCC 15.2.0 and QEMU 10.2.1.
Three full kernel builds and W=1 checks of cacheinfo.o/topology.o passed:
multi_v7_defconfig with and without PREEMPT_RT, and an ARMv6+ARMv7 SMP
PREEMPT_RT configuration for ARM11 MPCore. Seven boot checks passed:
- virt, Cortex-A15, 2 and 4 CPUs, with and without PREEMPT_RT;
- vexpress-a9, Cortex-A9 with external PL310 L2, 4 CPUs, RT and non-RT;
- realview-eb-mpcore, ARM11 MPCore, 4 CPUs, PREEMPT_RT.

With DEBUG_ATOMIC_SLEEP enabled, the RT boot warning was absent.
CPU1 offline/online succeeded in every run, with identical cache sysfs
output before and after. ARM11 exposed no cache leaves, as expected.
RT and non-RT cache output also matched on each ARMv7 machine.
All four stable patch IDs match v1.

Earlier testing of these same diffs also covered DT cache-description
corner cases. On September 12, the full series passed on a Raspberry
Pi 400 with a 32-bit PREEMPT_RT 7.2.6-rc1 kernel: the boot warning was
absent and all 12 cache sysfs entries matched the baseline. CPU hotplug
was unavailable there. That hardware test and the DT corner-case tests
were not repeated on this rebased tree.

v1: https://lore.kernel.org/r/20260912195552.76673-1-kmehltretter@gmail.com/
[1] https://lore.kernel.org/r/CAD++jL=7OSrPMax9GRj3D7ehjmmG2uMyws53F8U0x7YGx+RNOQ@mail.gmail.com/

Karl Mehltretter (4):
  ARM: cacheinfo: avoid out-of-bounds write in populate_cache_leaves()
  ARM: cacheinfo: count external caches in early_cache_level()
  ARM: cacheinfo: guard the CLIDR read in populate_cache_leaves()
  ARM: topology: allocate the cacheinfo early on the boot CPU

 arch/arm/kernel/cacheinfo.c | 49 +++++++++++++++++++++++----------------------
 arch/arm/kernel/topology.c  | 13 ++++++++++++
 2 files changed, 38 insertions(+), 24 deletions(-)

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
