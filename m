Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD62C0272
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771554608; cv=none; b=NLAlUZL3wfrGj1JB3uEdfsH9hdKy4L9eVi2F+w/gRCKUTDH6QmGQPXketUlr0B4s8mfyFL9eeoLpCGsd6rWwg+8vuNxs3pu54e+jt1UxWpA1+acU+u7+dN2i9OkG3fqNgwtijECYF/3mQcuCJp8XavLTQbABz6mvN9esx/2W3IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771554608; c=relaxed/simple;
	bh=WwFi8HQeIytlLwps/gKA3sG0QWpe3RQiJvqaAQl4bxE=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=akkvvZri8E6kZUjtAajKyTrUBktTl4yAHr8Rid6qViMgMYLNUTlCqoVM6pAj+4IrRLaLb83TQ++n61Mfflm+zX2YBLSMDomMisNEED4FQ2f0YsNtyp7OGaxKabtp7KsAvk4aPFwZXnS4TBEnwiAAH30l9CGjLAUg0pKeJhjVVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=mb2qoYR3; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="mb2qoYR3"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ba9d13f10eso2529959eec.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Feb 2026 18:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1771554606; x=1772159406; darn=lists.linux.dev;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wTVPhgyr8PV+PNvAGl8BGgwrB4HvIMy/ms2uo0tzO8=;
        b=mb2qoYR3M8yzMNBH3jqR8q/zu+3QqLsR5fbM0r5tSHZU9R3TiONKKoUOHFkiFxyBUI
         V93i7l7YXt7sreJplDId9Ssvnfn/fqtZAg9bake/QDJelvWtBO/UgHuwaaTTlymhN0ax
         gWNMVDw2b1tORgJyQSVi4sMTsL6PbCSYclHYWjQ+BFYaNRj+90hIp2O0I8QtHypybLcS
         dJydTn94k46GhWGcVzR8x18Gf15o/ogICrew4Ocn8rrBjeauLqW/G11oLlp5nOE5iln3
         EURfRE0+SzMrJ80gCo2qis8lutQB/VfCtbo5/ad02ZG3JME9zIpBlkeo5LSd0JWYmHOW
         3mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771554606; x=1772159406;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wTVPhgyr8PV+PNvAGl8BGgwrB4HvIMy/ms2uo0tzO8=;
        b=I1t64UnXLvT7ZOSMPhqH9MuGk7YvYHWZc+q/93KbhCBGEgeXw5QQI7vmMAgoiTfIkx
         ZAu6e5GDZPDQzycl4LjgiBtQdhM/uBYiNVxCqzUXWkd6nVBM+o6SgmJ614FWp58iz6F9
         InQge279iRJJCbAZRaFvF/2GM2VpaxlTBbTFwqoVHjH+ni7mMZeEWs5ye2ncf4oxMie7
         wRBnjbgOtShtv78hCHlnM4dL9nMmQcEWssGW+cj5CVJZPyxnIf29NXk4XdYPjwjFNMR5
         ulFgcn56SoJIZhw/mkKuNdtrD56ZySQnbQyqsiwSR4uzddN7n4hvFBipwRylzXVPObAL
         VsKQ==
X-Gm-Message-State: AOJu0YwX9cRdjqKZ/3Ug80VncYysmOcn1dnFNLCqrPgSgVPfHEpyl6Sc
	5W1Cj+kyLS3Rq+WJ3ekIWtoiY+In0F2/hGTr5rWovMffrtgqnm6ku+IGxtw+0i9tuwE=
X-Gm-Gg: AZuq6aJZbCnjj7vf0VStgmfnUkQx2fsgXCJbOrNIHh7batrHBVgjnQr8W7bZ6shF/fr
	xXkEurtI1ufiJ6tGmhKwult/CXyHsHNd0+u8u8t4iInrSMcsnBGhc7YQZGOLg8LiAsTymFy5HMq
	I4ai7qiCAQEF4huwdGdTcy7YIPQLTWhTvXPGrDA7rlZ/TPcxWLrTaebG4VTgtkDnsaLiogCV2zB
	bMf9iVSqt8TStwbYwuBQLxTKs0P8dVOl6b+D8s0sl3k6uJSeeeARPxC/dSoatFOtw+XWKYGkfj6
	pynv2WRvn2pPBDHj1Y/AHxFrc/Jx5zxYkQhIJyxFaiTu1+88rlzMeYzIZF04YQoksskVnaN+8h5
	HH2cMDxoT7F44y2P0/N3SutBOf6lij1sT0LD8ODK5Rbp/fCzNv5AMDGI1AeTXL2+sjtq4nzi3eK
	dGOoUULQOsPVfGBLyG
X-Received: by 2002:a05:7300:aca6:b0:2ae:5ffa:8da4 with SMTP id 5a478bee46e88-2bd5b273039mr2175139eec.1.1771554605711;
        Thu, 19 Feb 2026 18:30:05 -0800 (PST)
Received: from d14e337afe00 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb543e1dsm22369550eec.4.2026.02.19.18.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 18:30:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable-rt/v5.10-rt-next -
 191bca0b024d219b5488328baa8829d0bcc9093a
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: linux-rt-devel@lists.linux.dev
Reply-To: kernelci@lists.linux.dev
Date: Fri, 20 Feb 2026 02:30:04 -0000
Message-ID: <177155460425.304.7123823892305008724@d14e337afe00>





Hello,

Status summary for stable-rt/v5.10-rt-next

Dashboard:
https://d.kernelci.org/c/stable-rt/v5.10-rt-next/191bca0b024d219b5488328baa8829d0bcc9093a/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
branch: v5.10-rt-next
commit hash: 191bca0b024d219b5488328baa8829d0bcc9093a
origin: maestro
test start time: 2026-02-19 16:29:12.132000+00:00

Builds:	   21 ✅    1 ❌    0 ⚠️
Boots: 	   30 ✅    0 ❌    0 ⚠️
Tests: 	  626 ✅    2 ❌   90 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+preempt_rt
    - Architecture/compiler: arm64/gcc-14
      - rt-tests.signaltest
      last run: https://d.kernelci.org/test/maestro:69977f6d7b34c330553ad533
      history:  > ✅  > ✅  > ⚠️  
            



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
