Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996711E50D
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Sep 2024 00:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727311005; cv=none; b=aV0g5rR6+LqfEA6X9lat+SF5A1+WQBW5+SVBX6XGTgYRCn9rvVGjNhsf4RL9YRY5rBHWWYLYW5eiGnOIW/ggI5rbyZjDTxROY/KR3faPgjYEPATY7XiKarx/879ZzIlL/3hDRL5YyFldIxvPdJaE788IXQ73UAue53VBZEWBKzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727311005; c=relaxed/simple;
	bh=u1HuKIIX5BcL9glA2wU2/aSzofjOAzrr/QGPh0o/Cw0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LtxTiAWzLIMy1vNzoVYvP3HLzGXIh3O5opv8OveBhOommM92YfIVFydE9dG9TKxVLAYQ+Z0/tuMY9sbnPksyjTwWnolWbOZAExRINmjtkpxiWFalw4MojUmi0Mnk1UJBOpHsAyU8zry2YyU1Yhcy8Hnh5KK5bdx2pDwDUqWAUkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=contractor.linuxfoundation.org; spf=pass smtp.mailfrom=contractor.linuxfoundation.org; dkim=pass (2048-bit key) header.d=contractor.linuxfoundation.org header.i=@contractor.linuxfoundation.org header.b=Q/ImvbWH; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=contractor.linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=contractor.linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=contractor.linuxfoundation.org header.i=@contractor.linuxfoundation.org header.b="Q/ImvbWH"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53568ffc525so549914e87.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 25 Sep 2024 17:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=contractor.linuxfoundation.org; s=google; t=1727311001; x=1727915801; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LWHzgZGttdp/EiWVhAbA9Ae4j+ZyK0E3RqeOPUe7s/k=;
        b=Q/ImvbWHG63p+b6+CdFskQLZqBJY3FKO5Qnz097GpbdIsoyqRXNcSSjTEb2g4bNMiC
         uO/ymhRdjL3ZuAUgXsI9c8TAYYBer7fbfFHNKt2UhC2v86mNd1MCPvpg9dRLdUVWvulU
         Hb+6t3EV/1CDS/tVo5QApYHsOcASXY+9wo/UBPZrO/e0gc96Bo14UXzH+HuLesUUWFih
         BWLLUxnHiG1WH93yrT9gPO1h4F27OzcgntNMwgNXZQY2d0hTfST6LUwWhoOkNiV9V/i1
         yqbN5cesjM9+bo4ZkFMaVbICjnHwFixVOGgLIdqVNw2gvrlY5eSHd7z1T9BOgd/7DhgI
         XziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727311001; x=1727915801;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWHzgZGttdp/EiWVhAbA9Ae4j+ZyK0E3RqeOPUe7s/k=;
        b=oz9DEyPGbN35KJQrGAxWQLfdJ/UHrGfrCFN6zk9TTFarbkivv37zVWMKKvYQbIqLt3
         gaJ/iNH2DSmVRS0Lu4kkyMbNzj+QP7PTe12zNA/eDrimOMA35zsesoeGdPS6PpTCeB5s
         sZMTXxYfqbJ1MnHJXOMkwvCQBeABMkyrvFqlXW7UpkRE6xibMVyS2QP66OARC5Z2E4dx
         73H3kibM2APNHbtSambRxvFatdpcTC6Frqr+8iNjRVqwUHRg+MNNfrAoqhGW6i30RWWx
         lwyiD1AAQ3m/qQCrIGfwbww3YmiQCz+hkh/0BcvfArC6p3vmqZOUx6Gsxw41s7JgGqIa
         qZjA==
X-Gm-Message-State: AOJu0Yxy34vhoosLfiIk64pk4IIsE2T8beT4Zk+Lq3tClPv/gOTPdvrX
	/gGyXMNd21gr73COXG3MjgUITIA5IZrytFh84xIGhcEXYVWaxikbo5DlZcugKHg7zsqUMIerK1m
	mfxOp4GZTwI+09zL81mM63dxvzVJ+F5zV6b11jxeFpyIV1KNhTjg=
X-Google-Smtp-Source: AGHT+IEtD3MXlQySvlOUV03smEXyhyCGhYS01WnKJ9Nl24xoCDFp/3unmMfzrUvkF7xuvCsMaYSt0us3JH7JrikgraA=
X-Received: by 2002:a05:6512:3ca4:b0:52c:cc38:592c with SMTP id
 2adb3069b0e04-538693ab0c1mr2942663e87.0.1727311001116; Wed, 25 Sep 2024
 17:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Shyam Kumar <skachukattu@contractor.linuxfoundation.org>
Date: Thu, 26 Sep 2024 06:06:30 +0530
Message-ID: <CAH=dH98D8soESfhSATukYkb-FLK6byCnc=sjn2crvk67PQKzXA@mail.gmail.com>
Subject: Test mail
To: linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello

This is a test message to test successful delivery and start the
 archive for the list. Please ignore.

-- 
Regards
Shyam Kumar
The Linux Foundation Core Projects
