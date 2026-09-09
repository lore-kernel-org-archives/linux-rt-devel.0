Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29A24BFE60
	for <linux-rt-devel@lists.linux.dev>; Wed,  9 Sep 2026 22:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994759; cv=none; b=qe3EvEG+ua4T+A8FluBb0OOeSyFCE9AWL0LVefluimUXdvrNVA7rcpUlwFSRHLaUr9GLrqmdYck3noWjO+No6E4eq6rhBdZIcUkgq7sUWfTGXcW58rw9VVesy5J7gtl9+fa05uWHDlGlDghfrACJBD7J07oWa5Yldkx9bjSDj94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994759; c=relaxed/simple;
	bh=smTZp+fwrcL8LRU+cUswUL9Rv8CHyW2oRBCPTYSFi+o=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=CQgbnneNmP36b5Em6mTTl+LwwGXqIQ9+jhMxuQSXb1pJPRbwCmaZr3C7ExMPz/plPbhjlHQpdUINyXqAkbikD0Y36YAtvKe7PuuMMnYdHoOu1jW0dNel+KgmXotxy+QKgUcxPCorQd0B0nmZV4Zz+ylcnZjLDDRdwEouW6QAxRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=OkcWTDYx; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="OkcWTDYx"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso8302824a91.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 09 Sep 2026 15:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1788994746; x=1789599546; darn=lists.linux.dev;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NmzQVAjQi1BMSP0izW97Ra253U/DhrBqA+/Yc0fRcqY=;
        b=OkcWTDYxgB4SQn6DtRkIajyW6hCsVQ3QCa8vuzX/eJmUy0n4H9Z+l9N73aQ6HriUQX
         PuSGMyqvaCA58vLuyCYsOVKMiw9ixZjZrclpVhimB5bKuzcqrjYrx/gQMg4NVLeSPbFe
         ImzYdpkHqxRdEX+ylLgE58He1kC70lIWbYcU1UsKFLcK3I1BInFmqfN4DDFAHzV2RAzp
         27pxl7BAwMY0Ijh9x0gF4dehZT8Eo1R8mAQycEmYSUGjEoS61pCEcqfGWglBytK2Eb4a
         9vqpGxMvF2phhMSIvxBwGkiwkoIpyqpxUICKfu1Vyc7KXdW82eCPDr+O5hP/Pmd5GxQM
         k+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788994746; x=1789599546;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NmzQVAjQi1BMSP0izW97Ra253U/DhrBqA+/Yc0fRcqY=;
        b=CEhRpeB5Td7xgbNrPwydm2MDaRuhSdHDdJlvJXvNv0ok89JTCi+lOkqhm+Rm2WwSb+
         tMCbKWtUvMguUGCzW8PfmUfFUScP9HUu1ndbtNUR14iDEAeuWsOD99tQoNZgwRApsaim
         9E0q8Zmkb402fL8aia0rR/dSg8Vqt5+JdUTcseiuSjMmGmni3+TnLRsBhoqmEpFm5tlA
         6ZVExDCYEJnyeCaolTzq84ODVRyD2OJASMCZYmH5J3udS1vLRnQML5AVgbVLF4OSHgIm
         daQD5MGpSqr91C5dEotdsM7UjRsFfvj4YEhynKrc5xhktj1vcYV8W91ClXlXq9j4rFkq
         sNAw==
X-Gm-Message-State: AFuF++mgtB5cYhxaaU4GuEexw3gNNW+5A2zKuvl1t7e5c2sydfPXXKrA
	7jtrHkM+mp7AJ19IlXPoAIwgVnXC6idJZ6TyQXK7/I0FWzfwkBVcRY8zQL6j282/QUEGwwNESGH
	LQ6KG
X-Gm-Gg: AYBFou2BRNVNHcbzcGvM4tzkI3z29OALNZVcoHn/89NOCEznePQETNHCOHHTAXPpUv+
	5y8nqAz/7VIeV/7RxGcD7JM9D1D02jcL18jBoCqbhyATFVHiwv4+P7XVj+iQ9yIngiTkvjxvjju
	/zAu3IPSMZviIbyko2aI2kvKIJB8Cwp0M8vLv17ltxtE+epor3wX3KJqxg/LyTq1TcvhLX0SI7N
	Si7oUcCAouFhFyG1YFSaoO5vxrTIPbQJ0BqkYaFn4n6u76e8eSRwan5ZpSruqqG84bJT35B+eLA
	UwU8wSXtIEL35Co0yVJixOBJgOopN2oTX3gmCXCXXThR4z1Sktiyl/rrRlFzokH5wSA3EzROFqc
	0vEcSQCIopsiO4ztuZm5ICp/5GhHTnoveuHpKb8hd1EecFJiHMuH85bR4YTUS83yO6iJUSyImCm
	HazkXC0DKkFnkMFjweFGcCz5k6hjKLOGBXI939Tu3tyfjW+lG3pwXSRCdRmlnlzDo=
X-Received: by 2002:a17:90a:d647:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-39b261074camr54350253a91.6.1788994746220;
        Wed, 09 Sep 2026 15:59:06 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432424d27asm62856334c88.2.2026.09.09.15.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1ydC92Ni42LXJ0OiAoYnVpbGQpL3RtcC9rY2kv?=
 =?utf-8?b?bGludXgvaW5jbHVkZS9saW51eC9mb3J0aWZ5LXN0cmluZy5oOjgwOjMzOiBlcnJv?=
 =?utf-8?b?cjog4oCYX19idWlsLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: linux-rt-devel@lists.linux.dev
Reply-To: kernelci@lists.linux.dev
Date: Wed, 09 Sep 2026 22:59:04 -0000
Message-ID: <178899474430.3606.7250196618057750493@kernelci.org>

New build issue found on stable-rt/v6.6-rt:

---
/tmp/kci/linux/include/linux/fortify-string.h:80:33: error: ‘__builtin_strncat’ specified bound 18446744073709551609 exceeds maximum object size 9223372036854775807 [-Werror=stringop-overread] in kernel/trace/trace_events_hist.o (kernel/trace/trace_events_hist.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
    inlined from ‘event_hist_trigger_parse’ at /tmp/kci/linux/kernel/trace/trace_events_hist.c:6774:3:
/tmp/kci/linux/include/linux/fortify-string.h:80:33: error: ‘__builtin_strncat’ specified bound 18446744073709551609 exceeds maximum object size 9223372036854775807 [-Werror=stringop-overread]
   80 | #define __underlying_strncat    __builtin_strncat
      |                                 ^
/tmp/kci/linux/include/linux/fortify-string.h:479:24: note: in expansion of macro ‘__underlying_strncat’
  479 |                 return __underlying_strncat(p, q, count);
      |                        ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:7d92633e4f2c556f5a2fc8d8b519061ddc1bd32d
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
- commit HEAD:  d36765fb87b0b4546ad185f2362986638dd3e759
- tags: v6.6.156-rt79

# Builds where the incident occurred:

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa1dfda20239ade90198c24

#kernelci issue maestro:7d92633e4f2c556f5a2fc8d8b519061ddc1bd32d

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
