Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457C4221FB6;
	Mon, 22 Jun 2026 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123115; cv=none; b=ZrPcESYZPz4wxixxGJpvsDdfgjvOVu2ylTMzgQtTowu0AMGzCcSQWLg9U2JrTUv3PQYIdi8L2Y4rdz+DPPFNRtxHI8ILia1sM9fajFL02xGwRre6okL0+s6draaLftf6Fwv8brKIkVOj5Asrw9eEsfhJgG5BHnCk7jd8SFQ+6OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123115; c=relaxed/simple;
	bh=3yRpQcwiT2mvufrj+e4CGgzMBx8QkgArCHqZ5uQ3gfo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gjDw+RjWJ/bX70JZIVcT61ff4/Gu1B14TPPHZYQmM8X91zIbqaaOZHjUwbkjQfyKxdC6pcZzYLwbgqdqeb7yJlHlvRArRjRgrKwZ7PCGs+58Ur889jgQL0DinY1M4bL3VapvJmWL1Kj/GLfModLdPi0iAwmuoowybqkRqZpJtPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSSUAuE4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSSUAuE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08741F000E9;
	Mon, 22 Jun 2026 10:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782123113;
	bh=3yRpQcwiT2mvufrj+e4CGgzMBx8QkgArCHqZ5uQ3gfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CSSUAuE4xNkK0kVkdM8R9FKnhRJM2epW0rLOg8KDp3Re9VR/RRfZ1Q0VXHa6KfCsQ
	 DUcXV5q0r8w7B+u3siuxkqHAeACG0GVgJv+fpeT5EOj34te8hzzywd6fQbmAVaDdka
	 arNpcIjuOcrB+WfOCWWvUl+XHx6QRgddVeG29rJw6uJp4or6DB6p8qjtl4VkDJIpaf
	 TXkb1nIT/kUUyz05uEApOUMj00OmdIrTiIrec7IqV0YwfNThDWRvUvmF5vHgrZ1iIy
	 s9VsLsPUSrEzKwhK0Hhjm6k10ViclB29+WoaVmeqGoy7/tYpaA1EqSZzUShjptEJFk
	 SBLVSQKBRI8Tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/13] net/funeth: Switch to higher-level allocator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260622-alloc-trylock-v2-9-31f31367d420@google.com>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-9-31f31367d420@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 10:11:53 +0000
Message-Id: <20260622101153.C08741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message logic regarding __alloc_pages_node and alloc_=
pages_node is inverted.
--

commit ab883602f87dc726f65726ac01fce73a498907b3
Author: Brendan Jackman <jackmanb@google.com>

net/funeth: Switch to higher-level allocator

This commit replaces __alloc_pages_node() with alloc_pages_node() in the
funeth driver.

> The difference between __alloc_pages_node() and alloc_pages_node() is
> that the former allows you to pass NUMA_NO_NODE.
>=20
> The former is going away and the latter works fine here so switch over.

[Severity: Medium]
Is this description inverted? Looking at include/linux/gfp.h, it is
alloc_pages_node() that safely handles passing NUMA_NO_NODE by checking
if (nid =3D=3D NUMA_NO_NODE). On the other hand, __alloc_pages_node() conta=
ins a
VM_BUG_ON() which strictly prevents passing NUMA_NO_NODE (-1).

The code change itself appears correct since the node variable can be -1 he=
re,
but could the commit message be updated to accurately reflect which function
handles NUMA_NO_NODE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-alloc-tryl=
ock-v2-0-31f31367d420@google.com?part=3D9
