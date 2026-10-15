Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2034CDDC3
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052251; cv=none; b=BZV4Iw1+DrnZQbN8b8Hef8EUxZnwBYT1EBnhSY1D8rDm3RR5usduqK/cCy5DJxhqYLzVHHYvep209c2v/DS9FMnv0LbBVv7qmP57Dshd6CO1MRwRwjmfdae8weMyuJqxWoVzBsoakXVlh57nA1RONX8R8kjo3t5ueAlv4Ps3wfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052251; c=relaxed/simple;
	bh=JXME0de5jdPM52GCMyjAEhHpX73VmQ/WWWKqBX3DhNA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hwFsXTYSFuFWdx6fxjMn2a+yJ13mgSJ59eQNPRWrE+ix/qU22brHBalfFBYuJNCII8KJgoBDRb4PkYUAOmp3Y/CQV69W+Q8jkEg6BUnYAkqMxMUqKWna7mqRXks7BIVAHyIo0I34rTAxAZboKBYEe3ZKxGLgQRrqolc9bBBSIyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RGZgkyEo; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGZgkyEo"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1721559b4so51915915e9.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792052247; x=1792657047; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lEAmeJCQDQzAAcly9NRmZ22CcOexoN0UM1XMCQxG41Y=;
        b=RGZgkyEobtBJ0iMBLKfIl5h6o1YTtKr6advp6KUH6QosrZ6SHZZWFjhN5vwdcuDbgG
         QpzKTCCJjAeh/sQcakisa6je6vU+JQZiGVhUW7/Xd3ofvdsz/Nts7J0tb53Pnj1ys2ib
         MF7aAHfk85BXr3lGx4cCmdfZW6/D5OWHDJxnUFjqkZl1Zp1fuVkdVJ2crdx5beM3dl+4
         0sAosUGCFITimnLZY4E9Q6R9m2yAP5hIgvP2bZqs9a0LboNldl3EBzaHje2loshzEoJn
         o4bsdTQV+OTFqDK3vT8pLBAJDE4dIz/GExHyaC5ZW9RzqNmXZXNQs6K4s3ctPUnYypgR
         TA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792052247; x=1792657047;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lEAmeJCQDQzAAcly9NRmZ22CcOexoN0UM1XMCQxG41Y=;
        b=auqIxReK1l/GD1T5uD5l6e8aj1nguRamocJbDic6ednuzAgeip8N/QpCFpA/thvoWn
         VnKoyCA+EFqt9DR8skhaPYJZkRNjIyFXBPiU6z67h0XzyZwvCt2KsWTDj9I9OHji/VLz
         EH+GtlLUtyiHZhXfhPy6ojaBdHXgb4akVaFdm1sS+Ch+GFFpIwO2DVmPS5mU1Qurn/Qg
         V+Ml7AHuDk39Z9gofPoNOjqPf80dpNpZ30YPcJ5GgbULY+nG8bH5DdRo6I6yQogENJrS
         NuXZP6p0M9dqFyZPWekEpkGqIP0KvzSqa4V/PX07LOCi7LuTZWUTUaueAE2yfYSMp++p
         tkxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWBjSW/5mTglOyci/Y/jz/fTNaS6C/KXzZ3+5LMSv2lRPBFv8C14Z+Ocmeev5kW0NXLU5Va4kbNNTblgKWaw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLrNWihMq6Oxrw56tDuh7ItIiFiHi/zqLdkiLeGuTAOREMtiF1u
	DRB01eRw8e70Y1mXf6qeONxL9WC0+br5KkUGzv7TpS4yFUNgrOhG8uXnbmge7VH2R2WdwIUKC5a
	KS3U3XzOHw/Je9Ex7vQ==
X-Received: from wrbdt15.prod.google.com ([2002:a05:6000:d0f:b0:48a:fe63:7751])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e91:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a18e4f56bcmr374090515e9.33.1792052244230;
 Thu, 15 Oct 2026 01:17:24 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:16:30 +0000
In-Reply-To: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261015-spinlock-irq-6-18-v1-0-72c58975994e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1965; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=tbLu840fS74ohR67+4JJFTeLBvEKY0/KR+uIRBsYVSg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq0IwJe2o/8TqL+TH5tUlOFF8aEsPieEsjuZtNm
 LOffRb9MzmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCatCMCQAKCRAEWL7uWMY5
 Rpj8D/9xL5arvb7G2uNuOTOfXWaop6GpZI1Zrl8xejkA3r9ZMeYdM+lXEbEEaRXaBVbJyclrWib
 cq1jy+AU9eSwwHdVAkQtp/TVfwQWjinFFM5YCtszCwuQrLUvFLYGpvz+A2bMp0cvoB5l7e01V1H
 0nli0nNsuKu3MVm5t9ipnvxO25fIl6dhVSBB6KyszYjc1QO+VfU+AKWAwyGpIUjpSaE3rnZG4+e
 gQ4F1MGaJHFK75FRmuPv+iQNm3au1U9CWTM4AUZO5fE5atZ7E0r7W0r9JZvh4E9LL3fuWMsWwdX
 BTy3qlxLvvV7pg/8+SfTXdAIbCAWWyXcXb1DvXgXvdkYnLjXxLowEMZXbS/Ox4NNg4xipxOdpn8
 u+WdYfzTdTHetJ5W+zbdX6B3AzRjLddP75n1+wJ3wJ8KEbnpCaYE38NKfLeU04YXa1M8aW8ce9t
 r+d7EB6Wlwy4PpmvuK8Q1yTLmKhqt00RFcgt4NXcLijqQVBn7kgh289AopXJj9rjtWCroZ3uw+f
 3cc4jfV9v0hFcE0cL9/COYWwB8GHA3nrzTCdWoBed6bL5p2zQIjXC1ymkHEH/VYELnYcNHBZ4zq
 CnoBdl1uYH36G7P9V935Ac5Hsn710aN6CEVvMx6Cu5tr+3TZHxhFevc0w4gwKzxcn6tTC+wBi+g 1Ws5v5Zi827fp5w==
X-Mailer: b4 0.14.3
Message-ID: <20261015-spinlock-irq-6-18-v1-4-72c58975994e@google.com>
Subject: [PATCH 6.18.y 4/6] rust: sync: Use super::* in spinlock.rs
From: Alice Ryhl <aliceryhl@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Gary Guo <gary@garyguo.net>
Cc: Boqun Feng <boqun@kernel.org>, Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

From: Lyude Paul <lyude@redhat.com>

commit df9165ab5254acb2035919c6e0511de799c1e8c1 upstream.

No functional changes.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260807070218.27144-17-boqun@kernel.org
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/lock/spinlock.rs | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index d7be38ccbdc7..78432a598a45 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -3,6 +3,7 @@
 //! A kernel spinlock.
 //!
 //! This module allows Rust code to use the kernel's `spinlock_t`.
+use super::*;
 
 /// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
 ///
@@ -82,7 +83,7 @@ macro_rules! new_spinlock {
 /// ```
 ///
 /// [`spinlock_t`]: srctree/include/linux/spinlock.h
-pub type SpinLock<T> = super::Lock<T, SpinLockBackend>;
+pub type SpinLock<T> = Lock<T, SpinLockBackend>;
 
 /// A kernel `spinlock_t` lock backend.
 pub struct SpinLockBackend;
@@ -91,13 +92,11 @@ macro_rules! new_spinlock {
 ///
 /// This is simply a type alias for a [`Guard`] returned from locking a [`SpinLock`]. It will unlock
 /// the [`SpinLock`] upon being dropped.
-///
-/// [`Guard`]: super::Guard
-pub type SpinLockGuard<'a, T> = super::Guard<'a, T, SpinLockBackend>;
+pub type SpinLockGuard<'a, T> = Guard<'a, T, SpinLockBackend>;
 
 // SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. `relock` uses the
 // default implementation that always calls the same locking method.
-unsafe impl super::Backend for SpinLockBackend {
+unsafe impl Backend for SpinLockBackend {
     type State = bindings::spinlock_t;
     type GuardState = ();
 

-- 
2.56.0.385.gd3acb90ef8-goog

