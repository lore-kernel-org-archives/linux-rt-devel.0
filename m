Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE52F1E285A
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Nov 2025 02:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039552; cv=none; b=g6x5Dve1EgHM8cPYKvjR9mt9k01HUIZXcT/tvn9NaA7uyLNLnT21OF7hje1LBkFzH2m/isd7uLKNdrtHxnWt/0c1mkeXRbY+wyT5lRVnsF5abQxP0NiTpwg0YTzlucHdtfVd9hAUnA9zaVlcmHt4DYSoKv9ams37b+acdyR+mNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039552; c=relaxed/simple;
	bh=PuZ0cUildGF5PmMtqVKACsBROAwwYqWcNZnzWz4BBEQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=gGpWMZdpyYWwkUHVVIes0izXyWkMWwogDk4kEZ6QUzMUvCJcuPp9Pi79Pcrd/Jg2Z+b5ulsJz41+Vqw299hB73coheds7vrpHsIG/U1jOkz4uTJmBlt+oM0pgjaYneIac+Lj0QT+dRhKcaNDvFn7wDhiDQjn6UNaDERBga4VOjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=D13p4uZD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="D13p4uZD"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29ba9249e9dso5972795ad.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 24 Nov 2025 18:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1764039550; x=1764644350; darn=lists.linux.dev;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYciM8DmbjXA725tAeczsVnb+CY7BtLcTBtZmYnJRb4=;
        b=D13p4uZD+Z+9mh9Q2nZz4bDjSyZfgJbFMV/8zEOpRNoAEVMJzlKRlO/NPQhPytSIbN
         j5h88+Di0RUBKu+Gj9dmK1mF+oEjKhPiqD+U6Mm8+ADWzpMtq72prtij6GY+ZPOAwVqD
         iTGEBxS0+DEX2+4LES1VAQCkJZU4vRaQfdkxVTDh1Way1g1b8Hl9bY2nnTsxZmYi4tgX
         0QkrcgXdjo5c3K2g2XuK++rot+qccFwu8fg2TjyrLM1eg+R0PddPShJHJi9EaeMzQMXH
         pR5+NEIC0/KbPZyF4++zQ4ZPfVTSUZZ9otx06oMBu0yJ3rIj2NGXEMtKG+PEu/9FLa/1
         hGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764039550; x=1764644350;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYciM8DmbjXA725tAeczsVnb+CY7BtLcTBtZmYnJRb4=;
        b=OhMkx/cbal9kQYqdHGI0r8TudFNpunIfNOGn5UCrnRnmoj4HpzyQ2L+5LFoLFy3rih
         g9A4T3AutzYgIeAJkuMyTzX0KUgKsB5YSO4RKU6Sa1l5mo6TzRM21b1ehHCuFA1AIlFE
         qMaEuhFhT36yLhAg9NRDPmlud/45CKjeEjkmrMm9s9euOpAhMSMuJt1Er4KjJS+hHQZw
         WgjdFu+MpDX5mgEcZqVCt/4o13wQmWW1/LTVcipVEJWA6jDtNOrIUdpS/KCv5afjznL9
         PbU4gYw+qiTiQUGwcmifnw+U9yS7nK88uLQnxDjJVzqEISHaS5Ft66oSVryrUEOEWkXf
         no7w==
X-Forwarded-Encrypted: i=1; AJvYcCUHwsvYoftGv4GOIACXKuCzZjF6sin6VTTrHMMvVtE5ni3ECgUwLxzwPalgFvIKD9ZTO8CWfKAhLjY3p65WHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuR1ZARBsYE3r1ix9mfa7DlbqWbWSdvU8lEyhXUvJnKxDhqee8
	WKgw/apARWd4wCq+YTpnrig3vU6gi/5WiMXJtVo9ipemQsXXmLIdZ78DhmxQIe3Bvts=
X-Gm-Gg: ASbGncugrjBjyjc4Rym2oyBaM8DU4BL8EEpBQELY7LxeZYra3mD9Xkx6FWwRT9joz2O
	47GeY4+RcJ8noHFhl4G9vCU+GDdVcSQcsqlApRrlwoT2KL/mkRodUcmExD/5iMzP0V2VFm2zNnl
	EYb6qw+EkWo1GMRdlj5Tl+8BYX6spXVUEGUjoO8w9rlMOhqZyJaGofJmtroP4cS42qZ0Yg8smLa
	gYQZ7L7QuYDFywHvoS6BuVwW4tIZzAh4JxqAUh/OozSMYsTku69Rg1OnhD1FmrPiIOFYfLGqqhy
	ue2nuaZNRN5c8DV1Hadp+SDyTAAyAJvpYmxzm9gnXRfMoyp/nwngjS/4+u4gB7W2tNdkTT55ZuJ
	A+cClsrgUyWgH0XcNeojRFyMdFR/PFZZgCtCOdwGv9I8HUP0we/fRcyE9CAEoFEBx1nIebobkxX
	7GkIVS
X-Google-Smtp-Source: AGHT+IH/WcgVyT1mok4H38EpnBz38LzmJA69i8njV96xLo1XU0PICE0nwkm58+DJLlaq8L6L4cRfbg==
X-Received: by 2002:a05:7300:fb8d:b0:2a4:7a85:f02c with SMTP id 5a478bee46e88-2a719536638mr9577753eec.7.1764039550064;
        Mon, 24 Nov 2025 18:59:10 -0800 (PST)
Received: from f771fd7c9232 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc3d0bb6sm82469758eec.2.2025.11.24.18.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 18:59:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rt/v6.1-rt-next: (build)
 ./include/net/ip.h:456:14: error:
 default initialization of an obj...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, linux-rt-devel@lists.linux.dev
Reply-To: kernelci@lists.linux.dev
Date: Tue, 25 Nov 2025 02:59:09 -0000
Message-ID: <176403954885.358.6925837698022425297@f771fd7c9232>





Hello,

New build issue found on stable-rt/v6.1-rt-next:

---
 ./include/net/ip.h:456:14: error: default initialization of an object of type 'typeof (rt->dst.expires)' (aka 'const unsigned long') leaves the object uninitialized [-Werror,-Wdefault-const-init-var-unsafe] in security/selinux/avc.o (security/selinux/avc.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:dabc8a89dbfbb7a418c712c2c6c82e29bd2c9573
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
- commit HEAD:  14fd3f12318030025dddcaf840092144c3a99e89
- tags: v6.1.46-rt14-rc1


Log excerpt:
=====================================================
In file included from security/selinux/avc.c:30:
In file included from ./security/selinux/include/avc.h:17:
In file included from ./include/linux/lsm_audit.h:25:
In file included from ./include/rdma/ib_verbs.h:26:
./include/net/ip.h:456:14: error: default initialization of an object of type 'typeof (rt->dst.expires)' (aka 'const unsigned long') leaves the object uninitialized [-Werror,-Wdefault-const-init-var-unsafe]
  456 |                 if (mtu && time_before(jiffies, rt->dst.expires))
      |                            ^
./include/linux/jiffies.h:108:26: note: expanded from macro 'time_before'
  108 | #define time_before(a,b)        time_after(b,a)
      |                                 ^
./include/linux/jiffies.h:105:3: note: expanded from macro 'time_after'
  105 |         (typecheck(unsigned long, a) && \
      |          ^
./include/linux/typecheck.h:11:12: note: expanded from macro 'typecheck'
   11 |         typeof(x) __dummy2; \
      |                   ^
  CC      crypto/asymmetric_keys/pkcs7.asn1.o
  CC      crypto/asymmetric_keys/pkcs7_parser.o
1 error generated.

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-x86-69250b3ef5b8743b1f5fc039/.config
- dashboard: https://d.kernelci.org/build/maestro:69250b3ef5b8743b1f5fc039


#kernelci issue maestro:dabc8a89dbfbb7a418c712c2c6c82e29bd2c9573

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
