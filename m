Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F121C84A0
	for <linux-rt-devel@lists.linux.dev>; Fri, 19 Dec 2025 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766152316; cv=none; b=I6n+sk8TD/TEm2hAXHV+RZznTKVobAwy9zMid2et4RESU1fgIOA1qTgSO/oHTDTdf6KG2gvHfiCYqR+gCDTbwPkYVzj/y8MgVVbdvvnXutq98blwNc72zPpcRGqWNm4uNTgqmKmPUnf3YcqtDaDrtM7CXY2IBL3RV4bSIqcyVHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766152316; c=relaxed/simple;
	bh=Un+XdBU3I3O1U8e2BADpnWtabL+5oxe0RFc0dPO8UIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pf1gP+uqNyMcgdFeHwiR6xuY37fuufzt1vdkVYwXWlvnxchJv8yCtEqBSwA9WHAOlBYlcaTRgyUP3Ty+hn1Ly0HzLqEqrcOQor4bLn6hNJbYYGXtDpCmrl025T2jHekXLDtB1N/VuPurMd9Gsy46+U83/lf2kTyZ/hK71hrcb/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lq2ygRj3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lq2ygRj3"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0a33d0585so17123085ad.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 19 Dec 2025 05:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766152315; x=1766757115; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxgXlnQdF+cSEGYxVmlOlYry6iRAaIH6LrCkKfjLYP0=;
        b=Lq2ygRj3P82fDg9jzEStOURCzIcodUGVzksqfiqXSfAHVIoyoHNTgISp0mZgPHvtZS
         6R2VlJdbKUFfiez11TqGHSdukslwmiSxfbUjPtDSdPBsAfJAl+4X7dBjo6XfOux8hFPy
         lVKGKUtYyq1eEdFFWakpG19EKw8D/0qpsE/FdkL94mtqrlNVXO8LR1KdTAWX+2LqUain
         yBbMoULc8rOUewSK+yqMwJ46U3odOkhUYKmW2HEchc9OyaYYaLKivc2eJQh2qfLgR95M
         R6YzhrgDiR5LZyThTNDv9Wu+3VaQffeFTnYOWn7SMRZwNnnNSba6lcXtDU5+L26o3POE
         nOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766152315; x=1766757115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TxgXlnQdF+cSEGYxVmlOlYry6iRAaIH6LrCkKfjLYP0=;
        b=dXuLNe12CNk4CTLag1uXZzlv6PYVSOrA+1wuL7jCBXCR8TvBu24oJd+gIFTyo/gGE4
         RH6tBOJrIX/BUbxKi/dXWeGIxBDOuWsmikGN4LJXyLAoxUclxG5+QYoVKsKIxtKIy49d
         pnvtIeNVnJAYwwyY1UVfVKK4TK598vFqUY/w2hw8e4V7rndWr0frbA828CY0SrtIAWHw
         VAxLz9pw9SYj3Yy81vf8qrKHvb0beRYrRN2B5YB+xWaUkftsQCC13srxnexDF3NhZd7E
         GygFNrJIjdPmhUFKWEq6ESILtZ/4Nktz3TmoVeoTQW6/px/dfw9KGO03z3i3pEiFtASS
         2gTA==
X-Forwarded-Encrypted: i=1; AJvYcCXs+3KChlnr3CSFehzUE7fWMDET5k/gzmq/hsfdgkBENYgiLARK2/XEPEEUkDG/E0+6bgi2jlddRJrAPTVCqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPmBC6hMWhJ+3hOJN0axPlq5OG4AfO1u1uHp45f3vNLdOaBukB
	OSg8Bb9Wgx9kEBxuG5FGOAx/a4vDsEiqSn9WYJPkXtSafwC0Z3OZchM5
X-Gm-Gg: AY/fxX6ZUibA7PoilhcxSv3mYH7GDehUUuT0mUegRFmtxycR10M5kXjfE7g/DMhgfG2
	VSiNnlo6PMRwr/x4aeMSsW5wb4xwzb6euchqofQ9J3YV1kSDDveJ7C27a7wZJkOq42ww31ugDnQ
	s7MHqRoT+Tnjj3CFDlYhaC2f+FehVaOTsSH3NWOiMzmsNwjZdEeTObjU876Q2bodUJ+b7Rb5l7X
	EKUCxum6RWVmwdSJF6r/h8z4QWFL3VL+fkM1kP2uBw2h3MznQnlE2wobMcZqs3LEKxwFrJqHnh6
	RMuLZ5mo8bRYlBhezaF0SFWrUP//6Oi44ypgUuh92WKZS1PWo3GC9UqOITmmETRNZf5fN4WWGyz
	5efbAeUS05bDKcO+XTzS2mb0tFfp7CgXBeDpP6LU6yBdvk96uPF/GMpA85CEyRRImIk1PukNzOb
	HoO6WoA4sJVUDGtF9wHHs=
X-Google-Smtp-Source: AGHT+IHjUG82LmuZwnH/oGWzPoXaTmIsKDM9p+CYDLUCdGZKybZEGn81EAxGcdYrlvsBkx8OQqUwiw==
X-Received: by 2002:a17:903:120b:b0:2a1:325d:8219 with SMTP id d9443c01a7336-2a2f2735237mr27124255ad.38.1766152314579;
        Fri, 19 Dec 2025 05:51:54 -0800 (PST)
Received: from LilGuy ([2409:40c2:1162:1559:f712:85ce:d14f:d48c])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a2f3d5f5dasm23367305ad.82.2025.12.19.05.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 05:51:54 -0800 (PST)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: lgoncalv@redhat.com
Cc: akpm@linux-foundation.org,
	ast@kernel.org,
	bigeasy@linutronix.de,
	cl@gentwo.org,
	clrkwllms@kernel.org,
	david.hunter.linux@gmail.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	rostedt@goodmis.org,
	skhan@linuxfoundation.org,
	swarajgaikwad1925@gmail.com,
	syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com,
	vbabka@suse.cz
Subject: Re: [PATCH] slab: fix kmalloc_nolock() context check for PREEMPT_RT
Date: Fri, 19 Dec 2025 19:21:43 +0530
Message-ID: <20251219135143.7337-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aUVTJyd74OoCtSyN@redhat.com>
References: <aUVTJyd74OoCtSyN@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I agree that we can simplify this. I think !preemptible() would be
the most descriptive choice here, as it directly expresses the
constraint, we cannot take a sleeping lock when preemption is
disabled.
The updated check would be:
    if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())

I'll send a v2 with this change unless there are objections.

Swaraj
